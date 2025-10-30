import 'package:logger/logger.dart';

import '../dev_logger.dart';

/// 日志监听器回调函数类型定义
/// 用于自定义日志处理（例如：上传到 Sentry）
typedef LogListener = void Function(
  Level level,
  dynamic message, {
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
});

/// 日志工具类
/// 提供统一的日志输出接口，支持多种日志级别和自定义配置
class LogUtil {
  LogUtil._();

  /// 日志格式化器，控制日志的显示格式
  static LogPrinter? _printer;

  /// 日志输出器，控制日志的输出目标
  static LogOutput? _output;

  /// 日志过滤器，控制哪些级别的日志需要输出
  /// 默认只有 debug 级别才输出，如果需要全部输出，则设置 filter
  static LogFilter? _filter;

  /// 日志监听器列表，用于自定义日志处理（例如：上传到 Sentry）
  static final List<LogListener> _listeners = [];

  /// Logger 实例，单例模式
  static Logger? _instance;

  /// 获取 Logger 实例
  /// 使用懒加载模式，首次调用时创建实例
  static Logger get _log {
    _instance ??= Logger(
      output: _output ?? DevLogger(),
      filter: _filter,
      printer: _printer ?? PrettyPrinter(colors: false, dateTimeFormat: DateTimeFormat.none, methodCount: 0, errorMethodCount: 16),
    );
    return _instance!;
  }

  /// 配置日志器设置
  /// 在使用任何日志方法之前调用此方法
  /// 可以重复调用以更新配置
  ///
  /// [printer] 日志格式化器，控制日志的显示格式
  /// [output] 日志输出器，控制日志的输出目标
  /// [filter] 日志过滤器，控制哪些级别的日志需要输出
  static void configure({
    LogPrinter? printer,
    LogOutput? output,
    LogFilter? filter,
  }) {
    _printer = printer;
    _output = output;
    _filter = filter;
    _instance = null;
  }

  /// 添加日志监听器，用于自定义处理（例如：上传到 Sentry）
  /// 监听器将在每条日志消息时被调用
  ///
  /// [listener] 日志监听器回调函数
  static void addListener(LogListener listener) {
    _listeners.add(listener);
  }

  /// 移除指定的日志监听器
  ///
  /// [listener] 要移除的日志监听器
  static void removeListener(LogListener listener) {
    _listeners.remove(listener);
  }

  /// 清空所有日志监听器
  static void clearListeners() {
    _listeners.clear();
  }

  /// 通知所有监听器
  /// 内部方法，用于向所有注册的监听器发送日志事件
  ///
  /// [level] 日志级别
  /// [message] 日志消息
  /// [time] 日志时间
  /// [error] 错误对象
  /// [stackTrace] 堆栈跟踪
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
        // 忽略监听器错误，防止破坏日志记录
        print(e);
      }
    }
  }

  /// 输出调试级别日志
  /// 用于开发调试时的详细信息输出
  ///
  /// [message] 日志消息内容
  /// [time] 日志时间，默认为当前时间
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪信息，可选
  static void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.d(message, time: time, error: error, stackTrace: stackTrace);
    _notifyListeners(Level.debug, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// 输出信息级别日志
  /// 用于记录程序运行过程中的重要信息
  ///
  /// [message] 日志消息内容
  /// [time] 日志时间，默认为当前时间
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪信息，可选
  static void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.i(message, time: time, error: error, stackTrace: stackTrace);
    _notifyListeners(Level.info, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// 输出错误级别日志
  /// 用于记录程序运行过程中的错误信息
  ///
  /// [message] 日志消息内容
  /// [time] 日志时间，默认为当前时间
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪信息，可选
  static void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.e(message, time: time, error: error, stackTrace: stackTrace);
    _notifyListeners(Level.error, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// 输出警告级别日志
  /// 用于记录程序运行过程中需要注意的警告信息
  ///
  /// [message] 日志消息内容
  /// [time] 日志时间，默认为当前时间
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪信息，可选
  static void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.w(message, time: time, error: error, stackTrace: stackTrace);
    _notifyListeners(Level.warning, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// 输出指定级别的日志
  /// 通用日志输出方法，可以指定任意日志级别
  ///
  /// [level] 日志级别
  /// [message] 日志消息内容
  /// [time] 日志时间，默认为当前时间
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪信息，可选
  static void log(
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
