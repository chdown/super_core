import 'package:dio/dio.dart';
import 'package:super_core/src/config/super_net_config.dart';

/// 错误处理拦截器
class SuperErrorInterceptor extends Interceptor {
  static String sendTimeoutMsg = "请求服务器超时，请稍后再试！";
  static String connectionTimeoutMsg = "连接服务器超时，请稍后再试！";
  static String connectionErrorMsg = "连接服务器异常，请稍后再试！";
  static String badCertificateMsg = "请求证书异常，请稍后再试！";
  static String cancelMsg = "请求被异常取消，请稍后再试！";
  static String receiveTimeoutMsg = "响应超时，请稍后再试！";
  static String unknownMsg = "未知异常，请稍后再试！";
  static String badResponseMsg = "服务器异常，请稍后重试！";

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map<String, dynamic>) {
      var isNotMath = !(response.data as Map).containsKey(SuperNetConfig.successParam);
      if (isNotMath) {
        super.onResponse(response, handler);
      } else {
        if (!SuperNetConfig.successData.contains(response.data[SuperNetConfig.successParam])) {
          response.statusCode = response.data[SuperNetConfig.successParam];
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              type: DioExceptionType.badResponse,
              message: response.data[SuperNetConfig.errorMsgParam],
            ),
            true,
          );
        } else {
          super.onResponse(response, handler);
        }
      }
    } else {
      super.onResponse(response, handler);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err.copyWith(message: errorMsg(err)));
  }

  String errorMsg(DioException error) {
    switch (error.type) {
      case DioExceptionType.sendTimeout:
        return sendTimeoutMsg;
      case DioExceptionType.connectionTimeout:
        return connectionTimeoutMsg;
      case DioExceptionType.connectionError:
        return connectionErrorMsg;
      case DioExceptionType.receiveTimeout:
        return receiveTimeoutMsg;
      case DioExceptionType.badCertificate:
        return badCertificateMsg;
      case DioExceptionType.cancel:
        return cancelMsg;
      case DioExceptionType.unknown:
        return unknownMsg;
      case DioExceptionType.badResponse:
        return error.message ?? badResponseMsg;
    }
  }
}
