import 'package:dio/dio.dart';

/// 通用请求头拦截器
class SuperHeaderInterceptor extends Interceptor {
  Future<Map<String, String>> Function(RequestOptions options) headerParams;

  SuperHeaderInterceptor(this.headerParams);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, String> headers = await headerParams(options);
    headers.forEach((key, value) {
      options.headers[key] = value;
    });
    super.onRequest(options, handler);
  }
}
