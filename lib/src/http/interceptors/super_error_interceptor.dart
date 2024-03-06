import 'package:dio/dio.dart';
import 'package:super_core/src/config/super_net_config.dart';
import 'package:super_core/src/http/app_net_error.dart';
import 'package:super_core/src/http/super_http.dart';

class SuperErrorInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// 业务层返回401，表示用户过期
    if (response.data is Map<String, dynamic>) {
      if (response.data[SuperNetConfig.code] == AppNetError.errorToken) {
        response.statusCode = AppNetError.errorToken;
        response.statusMessage = response.data[SuperNetConfig.msg];
        handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
          ),
          true,
        );
      } else if (response.data[SuperNetConfig.code] != 200) {
        response.statusCode = response.data[SuperNetConfig.code];
        response.statusMessage = response.data[SuperNetConfig.msg];
        handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
          ),
          true,
        );
      } else {
        super.onResponse(response, handler);
      }
    } else {
      super.onResponse(response, handler);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.sendTimeout:
        throw AppNetError(code: AppNetError.errorConnection, message: "请求服务器超时，请稍后再试！");
      case DioExceptionType.connectionTimeout:
        throw AppNetError(code: AppNetError.errorConnection, message: "连接服务器超时，请稍后再试！");
      case DioExceptionType.cancel:
        throw AppNetError(code: AppNetError.errorConnection, message: "请求被异常取消，请稍后再试！");
      case DioExceptionType.receiveTimeout:
        throw AppNetError(code: AppNetError.errorConnection, message: "响应超时，请稍后再试！");
      case DioExceptionType.connectionError:
        throw AppNetError(code: AppNetError.errorConnection, message: "连接服务器异常，请稍后再试！");
      case DioExceptionType.badResponse:
        int code = err.response?.statusCode ?? AppNetError.errorUnKnow;
        String? message = err.response?.statusMessage;
        if (code == 400) {
          throw AppNetError(code: code, message: message ?? "错误的请求");
        } else if (code == 401) {
          SuperHttp.instance.cancelRequests(token: CancelToken());
          SuperNetConfig.tokenRefresh();
        } else if (code == 403) {
          throw AppNetError(code: code, message: message ?? "服务器拒绝请求");
        } else if (code == 404) {
          throw AppNetError(code: code, message: message ?? "未知的请求地址");
        } else if (code == 500) {
          throw AppNetError(code: code, message: message ?? "服务出现错误(500)");
        } else if (code == 502) {
          throw AppNetError(code: code, message: message ?? "服务出现错误(502)");
        } else if (code == 503) {
          throw AppNetError(code: code, message: message ?? "服务出现错误(503)！");
        } else {
          throw AppNetError(code: code, message: message ?? "未知错误($code)，请稍后再试！");
        }
      default:
        throw AppNetError(code: AppNetError.errorUnKnow, message: "未知错误，请稍后再试！");
    }
  }
}
