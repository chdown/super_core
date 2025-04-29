import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:super_core/src/utils/date_util.dart';
import 'package:super_core/src/utils/log_util.dart';
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
    String log = "打印日志异常";
    try {
      log =
          '🌐🌐⚠️⚠️ ${rep.requestOptions.uri}  ${rep.requestOptions.method}  ${DateUtil.getNowDateStr(format: DateEnum.normYmdHms)}  ${time}ms ⚠️⚠️🌐🌐\n【请求头】${JsonEncoder().convert(rep.requestOptions.headers)}\n【请求参数】${JsonEncoder().convert(rep.requestOptions.data ?? rep.requestOptions.queryParameters)}\n【返回参数】${JsonEncoder().convert(rep.response?.data)}\n【错误信息】${JsonEncoder().convert(rep.message)}';
    } catch (ex) {
      log = "打印日志异常";
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
    String log = "打印日志异常";
    try {
      log =
          '🌐🌐🌐🌐 ${rep.requestOptions.uri}  ${rep.requestOptions.method}  ${DateUtil.getNowDateStr(format: DateEnum.normYmdHms)}  ${time}ms 🌐🌐🌐🌐\n【请求头】${JsonEncoder().convert(rep.requestOptions.headers)}\n【请求参数】${JsonEncoder().convert(rep.requestOptions.data ?? rep.requestOptions.queryParameters)}\n【返回参数】${JsonEncoder().convert(requestData)}';
    } catch (ex) {
      log = "打印日志异常";
    }
    if (logEnable) LogUtil.i(log);
    super.onResponse(rep, handler);
  }
}
