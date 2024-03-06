import 'package:dio/dio.dart';
import 'package:super_core/src/config/super_net_config.dart';
import 'package:super_core/src/http/app_net_error.dart';
import 'package:super_core/src/http/super_http.dart';

class SuperHeaderInterceptor extends Interceptor {

  Map<String,String> Function() headerParams;

  SuperHeaderInterceptor(this.headerParams);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    headerParams().forEach((key, value) {
      options.headers[key] = value;
    });
    super.onRequest(options, handler);
  }
}
