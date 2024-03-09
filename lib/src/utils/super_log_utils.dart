import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class SuperLogUtils {
  /// 配置输出 Log
  static LogOutput? output;
  static bool isReleaseError = false;

  static final _log = Logger(output: output, printer: PrettyPrinter(printTime: true));

  static void d(dynamic message) {
    if (kDebugMode) _log.d(message);
  }

  static void i(dynamic message) {
    if (kDebugMode) _log.i(message);
  }

  static void e(dynamic message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode || isReleaseError) _log.e(message, error: error, stackTrace: stackTrace);
  }

  static void w(dynamic message) {
    if (kDebugMode) _log.w(message);
  }
}
