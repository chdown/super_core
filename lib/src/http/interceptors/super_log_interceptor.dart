import 'package:dio/dio.dart';
import 'package:super_core/src/utils/log_util.dart';

class SuperLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra["ts"] = DateTime.now().millisecondsSinceEpoch;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var time = DateTime.now().millisecondsSinceEpoch - err.requestOptions.extra["ts"];
    Map log = {
      '【HTTP ${err.requestOptions.method}请求错误-${err.type}】 耗时:': '${time}ms',
      'Request Message：': err.message,
      'Request URL': '${err.requestOptions.uri}',
      'Request Query': '${err.requestOptions.queryParameters}',
      'Request Data': '${err.requestOptions.data}',
      'Request Token': '${err.requestOptions.headers["Authorization"]}',
      'Response Data': err.response?.data,
    };
    LogUtil.e(log, stackTrace: err.stackTrace);
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var time = DateTime.now().millisecondsSinceEpoch - response.requestOptions.extra["ts"];
    Map log = {
      '【HTTP ${response.requestOptions.method}请求响应】 耗时': '${time}ms',
      'Request URL': '${response.requestOptions.uri}',
      'Request Query': '${response.requestOptions.queryParameters}',
      'Request Data': '${response.requestOptions.data}',
      'Request Token': '${response.requestOptions.headers["Authorization"]}',
      'Response Data': response.data,
    };
    LogUtil.i(log);
    super.onResponse(response, handler);
  }
}
