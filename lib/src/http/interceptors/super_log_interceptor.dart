import 'package:dio/dio.dart';
import 'package:super_core/src/utils/log.dart';

class SuperLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra["ts"] = DateTime.now().millisecondsSinceEpoch;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var time = DateTime.now().millisecondsSinceEpoch - err.requestOptions.extra["ts"];
    StringBuffer buffer = StringBuffer()
      ..write('【HTTP请求错误-${err.type}】 耗时:${time}ms\n')
      ..write('${err.message}\n')
      ..write('Request URL：${err.requestOptions.uri}\n')
      ..write('Request Query：${err.requestOptions.queryParameters}\n')
      ..write('Request Data：${err.requestOptions.data}\n')
      ..write('Request Token：${err.requestOptions.headers["Authorization"]}\n')
      ..write('Response Data：${err.response?.data}');
    Log.e(buffer.toString(), err.stackTrace);
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var time = DateTime.now().millisecondsSinceEpoch - response.requestOptions.extra["ts"];
    StringBuffer buffer = StringBuffer()
      ..write('【HTTP请求响应】 耗时:${time}ms\n')
      ..write('Request URL：${response.requestOptions.uri}\n')
      ..write('Request Query：${response.requestOptions.queryParameters}\n')
      ..write('Request Data：${response.requestOptions.data}\n')
      ..write('Request Token：${response.requestOptions.headers["Authorization"]}\n')
      ..write('Response Data：${response.data}');
    Log.i(buffer.toString());
    super.onResponse(response, handler);
  }
}