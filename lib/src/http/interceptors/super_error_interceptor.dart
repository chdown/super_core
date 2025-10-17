import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';

/// 错误处理拦截器
/// 请求是传参[SuperNetConfig.ignoreCheck]，错误处理器会忽略检查，可用于处理接口返回的特殊code值进行处理
/// 请求是传参[SuperNetConfig.ignoreErrorCodes]，错误处理器会忽略该code，可用于处理接口返回的特殊code值进行处理
class SuperErrorInterceptor extends Interceptor {
  /// 自定义错误信息处理函数
  /// 参数：[DioException] error - 原始错误对象
  /// 参数：[Map] responseData - 响应数据
  /// 返回：[String?] - 自定义错误信息，返回null则使用默认处理
  final SuperNetConfig superNetConfig;
  final String? Function(DioException error, Map responseData)? customErrorMsgHandler;

  SuperErrorInterceptor(this.superNetConfig, {this.customErrorMsgHandler});

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 如果不需要检查返回值，则直接跳过
    if (superNetConfig.ignoreCheckResponse) return super.onResponse(response, handler);
    // 对返回结果进行正确性校验
    // 是否忽略检查：如果请求时【Options(extra: {SuperNetConfig.ignoreCheck: true})】忽略检查，则跳过检查
    bool ignoreCheck = (response.requestOptions.extra[SuperNetConfig.ignoreCheck] ?? false) || response.data is! Map<dynamic, dynamic>;
    // 是否包含需要检查的code
    var isHaveCodeKey = response.data is Map<dynamic, dynamic> && (response.data as Map).containsKey(superNetConfig.successParam);
    // 需要忽略的code，即服务器返回的code不在列表内，则认为错误
    List<int> ignoreErrorCodes = response.requestOptions.extra[SuperNetConfig.ignoreErrorCodes] ?? <int>[];
    ignoreErrorCodes.addAll(superNetConfig.successData);
    bool isFinish = ignoreCheck || (isHaveCodeKey && ignoreErrorCodes.contains(response.data[superNetConfig.successParam]));
    if (isFinish) {
      super.onResponse(response, handler);
    } else {
      // 安全地设置响应状态码
      final statusCode = response.data[superNetConfig.successParam];
      if (statusCode is int) response.statusCode = statusCode;
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.unknown,
          message: response.data[superNetConfig.errorMsgParam] ?? response.data.toString(),
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
          if (_isRegionBlocked(error)) return HttpErrorMsg.regionBlockedMsg();
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
    if (error.response?.statusCode != 403) return false;
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
      Map map = {};
      if (error.response?.data is Map) {
        map = error.response!.data as Map;
      } else if (error.response?.data is String) {
        map = jsonDecode(error.response?.data ?? "");
      }
      // 检查是否有自定义错误处理
      if (customErrorMsgHandler != null) {
        final customMsg = customErrorMsgHandler!(error, map);
        if (customMsg != null) return customMsg;
      }
      // 业务中的错误msg
      if (map.containsKey(superNetConfig.errorMsgParam)) {
        return map[superNetConfig.errorMsgParam];
      }
      return error.message;
    } catch (ex) {
      return error.message;
    }
  }
}
