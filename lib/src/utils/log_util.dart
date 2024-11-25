import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogUtil {
  LogUtil._();

  /// 配置输出 Log
  static LogOutput? output;
  static bool isReleaseError = false;

  static final _log = Logger(
    output: output,
    printer: PrettyPrinter(colors: false, dateTimeFormat: DateTimeFormat.none, methodCount: 0),
  );

  static void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) _log.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) _log.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode || isReleaseError) _log.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) _log.w(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void c(
    Level level,
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) _log.log(level, message, time: time, error: error, stackTrace: stackTrace);
  }
}
