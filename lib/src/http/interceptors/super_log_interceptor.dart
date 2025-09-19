import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';

/// 日志输出
/// 可在请求[Options.extra]增加参数"logEnable",值为[bool]值，以过滤日志输出
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
    String log = "SuperLogInterceptor log print error";
    try {
      log = '''
      🌐🌐⚠️⚠️ ${rep.requestOptions.uri}  ${rep.requestOptions.method}  ${DateUtil.getNowDateStr(format: DateEnum.normYmdHms)}  ${time}ms ⚠️⚠️🌐🌐
      【请求头】${getLogData(rep.requestOptions.headers)}
      【请求参数】${getLogData(rep.requestOptions.queryParameters)}
      【请求数据】${getLogData(rep.requestOptions.data)}
      【返回参数】${getLogData(rep.response?.data)}
      【错误信息】${getLogData(rep.message)}
      ''';
    } catch (ex) {
      try {
        log = rep.toString();
      } catch (ex) {}
    }
    if (logEnable) LogUtil.e(log, stackTrace: rep.stackTrace);
    super.onError(rep, handler);
  }

  @override
  void onResponse(Response rep, ResponseInterceptorHandler handler) {
    var time = DateTime.now().millisecondsSinceEpoch - rep.requestOptions.extra["ts"];
    var logEnable = rep.requestOptions.extra["logEnable"] ?? true;
    var responseType = rep.requestOptions.responseType;
    var requestData = (responseType == ResponseType.bytes || responseType == ResponseType.stream) ? responseType.name : rep.data;
    String log = "SuperLogInterceptor log print response";
    try {
      log = '''🌐🌐🌐🌐 ${rep.requestOptions.uri}  ${rep.requestOptions.method}  ${DateUtil.getNowDateStr(format: DateEnum.normYmdHms)}  ${time}ms 🌐🌐🌐🌐
      【请求头】${getLogData(rep.requestOptions.headers)}
      【请求参数】${getLogData(rep.requestOptions.queryParameters)}
      【请求数据】${getLogData(rep.requestOptions.data)}
      【返回参数】${getLogData(requestData)}
      ''';
    } catch (ex) {
      try {
        log = rep.toString();
      } catch (ex) {}
    }
    if (logEnable) LogUtil.i(log);
    super.onResponse(rep, handler);
  }

  String getLogData(dynamic data) {
    try {
      return jsonEncode(data);
    } catch (ex) {
      return data.toString();
    }
  }
}
