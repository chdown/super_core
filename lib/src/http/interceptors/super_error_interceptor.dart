import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';

/// 错误处理拦截器
/// 请求是传参[SuperNetConfig.ignoreCheck]，错误处理器会忽略检查，可用于处理接口返回的特殊code值进行处理
/// 请求是传参[SuperNetConfig.ignoreErrorCodes]，错误处理器会忽略该code，可用于处理接口返回的特殊code值进行处理
class SuperErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    List<int> ignoreErrorCodes = response.requestOptions.extra[SuperNetConfig.paramIgnoreErrorCodes] ?? <int>[];
    ignoreErrorCodes.addAll(SuperNetConfig.successData);
    bool ignoreCheck = (response.requestOptions.extra[SuperNetConfig.paramIgnoreCheck] ?? false) || response.data is! Map<dynamic, dynamic>; // 是否忽略检查
    var isMath = response.data is Map<String, dynamic> && (response.data as Map).containsKey(SuperNetConfig.successParam);
    bool isSuccess = ignoreCheck || (isMath && ignoreErrorCodes.contains(response.data[SuperNetConfig.successParam]));
    if (isSuccess) {
      super.onResponse(response, handler);
    } else {
      response.statusCode = response.data[SuperNetConfig.successParam];
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.unknown,
          message: response.data[SuperNetConfig.errorMsgParam] ?? response.data.toString(),
        ),
        true,
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err.copyWith(message: errorMsg(err)));
  }

  String errorMsg(DioException error) {
    if (SuperNetConfig.showDetailError) return error.toString();
    switch (error.type) {
      case DioExceptionType.sendTimeout:
        return HttpErrorMsg.sendTimeoutMsg();
      case DioExceptionType.connectionTimeout:
        return HttpErrorMsg.connectionTimeoutMsg();
      case DioExceptionType.connectionError:
        return HttpErrorMsg.connectionErrorMsg();
      case DioExceptionType.receiveTimeout:
        return HttpErrorMsg.receiveTimeoutMsg();
      case DioExceptionType.badCertificate:
        return HttpErrorMsg.badCertificateMsg();
      case DioExceptionType.cancel:
        return HttpErrorMsg.cancelMsg();
      case DioExceptionType.unknown:
        return tryGetErrorMsg(error) ?? HttpErrorMsg.unknownMsg();
      case DioExceptionType.badResponse:
        return _handleServerError(error);
    }
  }

  /// 处理服务器错误响应
  /// 根据HTTP状态码返回相应的错误信息
  String _handleServerError(DioException error) {
    final statusCode = error.response?.statusCode;

    // 处理不同的HTTP状态码
    if (statusCode != null) {
      switch (statusCode) {
        // case 400: 错误码400，展示服务器具体错误信息，switch外部处理
        //   return HttpErrorMsg.badRequestMsg();
        case 401:
          return HttpErrorMsg.unauthorizedMsg();
        case 403:
          // 特殊处理403状态码，检查是否为区域限制
          if (_isRegionBlocked(error)) {
            return HttpErrorMsg.regionBlockedMsg();
          }
          return HttpErrorMsg.forbiddenMsg();
        case 404:
          return HttpErrorMsg.notFoundMsg();
        case 500:
          return HttpErrorMsg.serverErrorMsg();
        case 502:
          return HttpErrorMsg.badGatewayMsg();
        case 503:
          return HttpErrorMsg.serviceUnavailableMsg();
        case 504:
          return HttpErrorMsg.gatewayTimeoutMsg();
      }
    }

    // 如果没有特定处理或无法获取状态码，尝试从响应中提取错误信息
    final errorMsg = tryGetErrorMsg(error);
    if (errorMsg != null && errorMsg.isNotEmpty) {
      return errorMsg;
    }

    return HttpErrorMsg.badResponseMsg();
  }

  /// 检查是否为区域限制错误
  /// 通过检查响应内容中的关键词判断
  bool _isRegionBlocked(DioException error) {
    if (error.response?.statusCode != 403) {
      return false;
    }

    try {
      final dataString = error.response?.data.toString().toLowerCase() ?? "";

      // 检查常见关键词
      return dataString.contains("access denied") ||
          dataString.contains("blocked") ||
          dataString.contains("not available in your region") ||
          dataString.contains("region blocked");
    } catch (e) {
      return false;
    }
  }

  /// 尝试从响应中提取错误信息
  String? tryGetErrorMsg(DioException error) {
    try {
      final map = jsonDecode(jsonEncode(error.response?.data ?? ""));
      if (map is Map && map.containsKey(SuperNetConfig.errorMsgParam)) {
        return map[SuperNetConfig.errorMsgParam];
      }
      return error.message;
    } catch (ex) {
      return error.message;
    }
  }
}
