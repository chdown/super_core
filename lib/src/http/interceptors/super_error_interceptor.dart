import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';

/// 错误处理拦截器
/// 请求是传参[ignoreCheck]，错误处理器会忽略检查，可用于处理接口返回的特殊code值进行处理
/// 请求是传参[ignoreErrorCodes]，错误处理器会忽略该code，可用于处理接口返回的特殊code值进行处理
class SuperErrorInterceptor extends Interceptor {
  static String sendTimeoutMsg = "请求服务器超时，请稍后再试！";
  static String connectionTimeoutMsg = "连接服务器超时，请稍后再试！";
  static String connectionErrorMsg = "连接服务器异常，请稍后再试！";
  static String badCertificateMsg = "请求证书异常，请稍后再试！";
  static String cancelMsg = "请求被异常取消，请稍后再试！";
  static String receiveTimeoutMsg = "响应超时，请稍后再试！";
  static String unknownMsg = "未知异常，请稍后再试！";
  static String badResponseMsg = "服务器异常，请稍后重试！";
  static String requestMsg = "网络请求异常，请稍后重试！";

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    List<int> ignoreErrorCodes = response.requestOptions.extra["ignoreErrorCodes"] ?? <int>[];
    ignoreErrorCodes.addAll(SuperNetConfig.successData);
    bool ignoreCheck = (response.requestOptions.extra["ignoreCheck"] ?? false) || response.data is! Map<dynamic, dynamic>; // 是否忽略检查
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
          message: response.data[SuperNetConfig.errorMsgParam],
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
        return error.message ?? unknownMsg;
      case DioExceptionType.badResponse:
        return badResponseMsg;
    }
  }
}
