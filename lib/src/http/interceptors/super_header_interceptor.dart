import 'package:dio/dio.dart';

class SuperHeaderInterceptor extends Interceptor {
  Future<Map<String, String>> Function() headerParams;

  SuperHeaderInterceptor(this.headerParams);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, String> headers = await headerParams();
    headers.forEach((key, value) {
      options.headers[key] = value;
    });
    super.onRequest(options, handler);
  }
}
