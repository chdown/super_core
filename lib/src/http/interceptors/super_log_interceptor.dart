import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:super_core/src/config/super_net_config.dart';
import 'package:super_core/src/utils/log_util.dart';

///
/// 日志输出
/// 可在请求的[Options]中增加[Options.extra]参数"logEnable",值为[bool]值
///
class SuperLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra["ts"] = DateTime.now().millisecondsSinceEpoch;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException rep, ErrorInterceptorHandler handler) {
    var time = DateTime.now().millisecondsSinceEpoch - rep.requestOptions.extra["ts"];
    var logEnable = rep.requestOptions.extra["logEnable"] ?? true;
    Map log = {
      'http': rep.requestOptions.method,
      'time': time,
      'url': '${rep.requestOptions.uri}',
      'headers': rep.requestOptions.headers,
      'requestQuery': rep.requestOptions.queryParameters,
      'requestData': rep.requestOptions.data,
      'responseMessage': rep.message,
      'responseData': rep.response?.data,
    };
    if (!kReleaseMode && SuperNetConfig.showDebugLog && logEnable) LogUtil.e(log, stackTrace: rep.stackTrace);
    super.onError(rep, handler);
  }

  @override
  void onResponse(Response rep, ResponseInterceptorHandler handler) {
    var time = DateTime.now().millisecondsSinceEpoch - rep.requestOptions.extra["ts"];
    var logEnable = rep.requestOptions.extra["logEnable"] ?? true;
    Map log = {
      'http': rep.requestOptions.method,
      'time': time,
      'url': '${rep.requestOptions.uri}',
      'headers': rep.requestOptions.headers,
      'requestQuery': rep.requestOptions.queryParameters,
      'requestData': rep.requestOptions.data,
      'responseData': rep.data,
    };
    if (!kReleaseMode && SuperNetConfig.showDebugLog && logEnable) LogUtil.i(log);
    super.onResponse(rep, handler);
  }
}
