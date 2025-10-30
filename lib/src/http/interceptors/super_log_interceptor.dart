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
      log = StringBuffer()
          .apply((sb) {
            sb.writeln("🌐⚠️ ${rep.requestOptions.uri}  ${rep.requestOptions.method}  ${DateUtil.getNowDateStr(format: DateEnum.normYmdHms)}  ${time}ms ⚠️🌐");
            writeLog(sb, "请求头", rep.requestOptions.headers);
            writeLog(sb, "请求参数", rep.requestOptions.queryParameters);
            writeLog(sb, "请求数据", rep.requestOptions.data);
            writeLog(sb, "返回参数", rep.response?.data);
            writeLog(sb, "错误信息", rep.message);
          })
          .toString()
          .trimRight();
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
      log = StringBuffer()
          .apply((sb) {
            sb.writeln("🌐🌐 ${rep.requestOptions.uri}  ${rep.requestOptions.method}  ${DateUtil.getNowDateStr(format: DateEnum.normYmdHms)}  ${time}ms 🌐🌐");
            writeLog(sb, "请求头", rep.requestOptions.headers);
            writeLog(sb, "请求参数", rep.requestOptions.queryParameters);
            writeLog(sb, "请求数据", rep.requestOptions.data);
            writeLog(sb, "返回参数", requestData);
          })
          .toString()
          .trimRight();
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

  void writeLog(StringBuffer sb, String tag, dynamic data) {
    if (ObjUtil.isNotEmpty(data)) {
      sb.writeln("【$tag】${getLogData(data)}");
    }
  }
}
