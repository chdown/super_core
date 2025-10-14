import 'package:logger/logger.dart';

import 'dev_logger.dart';

/// Log listener callback
typedef LogListener = void Function(
  Level level,
  dynamic message, {
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
});

class LogUtil {
  LogUtil._();

  /// 配置输出 Log
  static LogPrinter? _printer;

  /// 是否输出emoji
  static bool? _printEmojis;

  /// 配置输出 Log
  static LogOutput? _output;

  // log默认只有debug才输出，如果需要全部输出，则设置filter
  static LogFilter? _filter;

  // 日期格式
  static DateTimeFormatter? _dateTimeFormatter;

  // Log listeners for custom handling (e.g., upload to Sentry)
  static final List<LogListener> _listeners = [];

  static Logger? _instance;

  static Logger get _log {
    _instance ??= Logger(
      output: _output ?? DevLogger(),
      filter: _filter,
      printer: _printer ??
          PrettyPrinter(
            colors: false,
            dateTimeFormat: _dateTimeFormatter ?? DateTimeFormat.none,
            methodCount: 0,
            errorMethodCount: 16,
            printEmojis: _printEmojis ?? true,
          ),
    );
    return _instance!;
  }

  /// Configure logger settings.
  /// Call this before using any log methods.
  /// Call again to update configuration.
  static void configure({
    LogPrinter? printer,
    LogOutput? output,
    LogFilter? filter,
    DateTimeFormatter? dateTimeFormatter,
    bool? printEmojis,
  }) {
    _printer = printer;
    _output = output;
    _filter = filter;
    _dateTimeFormatter = dateTimeFormatter;
    _printEmojis = printEmojis;
    _instance = null; // Reset to apply new config
  }

  /// Add a log listener for custom handling (e.g., upload to Sentry)
  /// The listener will be called for every log message
  static void addListener(LogListener listener) {
    _listeners.add(listener);
  }

  /// Remove a log listener
  static void removeListener(LogListener listener) {
    _listeners.remove(listener);
  }

  /// Clear all log listeners
  static void clearListeners() {
    _listeners.clear();
  }

  /// Notify all listeners
  static void _notifyListeners(
    Level level,
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    for (final listener in _listeners) {
      try {
        listener(level, message, time: time, error: error, stackTrace: stackTrace);
      } catch (e) {
        // Ignore listener errors to prevent breaking logging
        print(e);
      }
    }
  }

  static void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.d(message, time: time, error: error, stackTrace: stackTrace);
    _notifyListeners(Level.debug, message, time: time, error: error, stackTrace: stackTrace);
  }

  static void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.i(message, time: time, error: error, stackTrace: stackTrace);
    _notifyListeners(Level.info, message, time: time, error: error, stackTrace: stackTrace);
  }

  static void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.e(message, time: time, error: error, stackTrace: stackTrace);
    _notifyListeners(Level.error, message, time: time, error: error, stackTrace: stackTrace);
  }

  static void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.w(message, time: time, error: error, stackTrace: stackTrace);
    _notifyListeners(Level.warning, message, time: time, error: error, stackTrace: stackTrace);
  }

  static void c(
    Level level,
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.log(level, message, time: time, error: error, stackTrace: stackTrace);
    _notifyListeners(level, message, time: time, error: error, stackTrace: stackTrace);
  }
}
