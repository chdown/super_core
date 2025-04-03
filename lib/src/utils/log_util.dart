import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogUtil {
  LogUtil._();

  static LogPrinter? printer;

  /// 配置输出 Log
  static LogOutput? output;

  // log默认只有debug才输出，如果需要全部输出，则设置filter
  static LogFilter? filter;

  static final _log = Logger(
    output: output,
    filter: filter,
    printer: printer ?? PrettyPrinter(colors: false, dateTimeFormat: DateTimeFormat.none, methodCount: 0),
  );

  static void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.w(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void c(
    Level level,
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.log(level, message, time: time, error: error, stackTrace: stackTrace);
  }
}
