import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';

/// 错误处理拦截器
/// 请求是传参[ignoreCheck]，错误处理器会忽略检查，可用于处理接口返回的特殊code值进行处理
/// 请求是传参[ignoreErrorCodes]，错误处理器会忽略该code，可用于处理接口返回的特殊code值进行处理
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
        return error.message ?? HttpErrorMsg.unknownMsg();
      case DioExceptionType.badResponse:
        return HttpErrorMsg.badResponseMsg();
    }
  }
}
