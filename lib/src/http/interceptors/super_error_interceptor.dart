import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:super_core/src/config/super_net_config.dart';
import 'package:super_core/src/http/app_net_error.dart';
import 'package:super_core/src/http/super_http.dart';

class SuperErrorInterceptor extends Interceptor {
  final VoidCallback tokenRefresh;

  SuperErrorInterceptor(this.tokenRefresh);

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
      } else if (!SuperNetConfig.code.contains(response.data[SuperNetConfig.code])) {
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
        throw AppNetError(code: AppNetError.errorConnection, message: AppNetError.sendTimeoutMsg);
      case DioExceptionType.connectionTimeout:
        throw AppNetError(code: AppNetError.errorConnection, message: AppNetError.connectionTimeoutMsg);
      case DioExceptionType.cancel:
        throw AppNetError(code: AppNetError.errorConnection, message: AppNetError.cancelMsg);
      case DioExceptionType.receiveTimeout:
        throw AppNetError(code: AppNetError.errorConnection, message: AppNetError.receiveTimeoutMsg);
      case DioExceptionType.connectionError:
        throw AppNetError(code: AppNetError.errorConnection, message: AppNetError.connectionErrorMsg);
      case DioExceptionType.badResponse:
        int code = err.response?.statusCode ?? AppNetError.errorUnKnow;
        String? message = err.response?.statusMessage;
        if (code == 400) {
          throw AppNetError(code: code, message: message ?? AppNetError.error400Msg);
        } else if (code == 401) {
          SuperHttp.instance.cancelRequests(token: CancelToken());
          tokenRefresh();
        } else if (code == 403) {
          throw AppNetError(code: code, message: message ?? AppNetError.error403Msg);
        } else if (code == 404) {
          throw AppNetError(code: code, message: message ?? AppNetError.error404Msg);
        } else if (code == 500) {
          throw AppNetError(code: code, message: message ?? AppNetError.error500Msg);
        } else if (code == 502) {
          throw AppNetError(code: code, message: message ?? AppNetError.error502Msg);
        } else if (code == 503) {
          throw AppNetError(code: code, message: message ?? AppNetError.error503Msg);
        } else {
          throw AppNetError(code: code, message: message ?? AppNetError.errorKnowMsg);
        }
      default:
        throw AppNetError(code: AppNetError.errorUnKnow, message: AppNetError.errorKnowMsg);
    }
  }
}
