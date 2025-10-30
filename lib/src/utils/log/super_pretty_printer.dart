import 'dart:convert';

import 'package:logger/logger.dart';

/// 超级美化日志格式化器
/// 提供单行和多行日志的优化显示
class SuperPrettyPrinter extends LogPrinter {
  static SuperPrettyPrinter get defaultConfig => SuperPrettyPrinter(
        methodCount: 0,
        colors: false,
        dateTimeFormat: DateTimeFormat.onlyTime,
      );

  /// 内部使用的 PrettyPrinter 实例
  final PrettyPrinter _prettyPrinter;

  /// 是否启用单行优化
  final bool enableSingleLineOptimization;

  /// 单行时是否内联时间显示
  final bool inlineTimeForSingleLine;

  /// 多行时是否将时间嵌入边框
  final bool embedTimeInBorder;

  /// 单行判断的字符长度阈值
  final int singleLineThreshold;

  /// 包含边框的级别映射
  late final Map<Level, bool> _includeBox;

  /// 中间分隔线
  String _middleBorder = '';

  SuperPrettyPrinter({
    this.enableSingleLineOptimization = true,
    this.inlineTimeForSingleLine = true,
    this.embedTimeInBorder = true,
    this.singleLineThreshold = 160,
    // 下面的都是原始默认参数
    int stackTraceBeginIndex = 0,
    int? methodCount = 2,
    int? errorMethodCount = 8,
    int lineLength = 120,
    bool colors = true,
    bool printEmojis = true,
    DateTimeFormatter dateTimeFormat = DateTimeFormat.none,
    Map<Level, bool> excludeBox = const {},
    bool noBoxingByDefault = false,
    List<String> excludePaths = const [],
    Map<Level, AnsiColor>? levelColors,
    Map<Level, String>? levelEmojis,
  }) : _prettyPrinter = PrettyPrinter(
          stackTraceBeginIndex: stackTraceBeginIndex,
          methodCount: methodCount,
          errorMethodCount: errorMethodCount,
          lineLength: lineLength < 60 ? 60 : lineLength,
          colors: colors,
          printEmojis: printEmojis,
          dateTimeFormat: dateTimeFormat,
          excludeBox: excludeBox,
          noBoxingByDefault: noBoxingByDefault,
          excludePaths: excludePaths,
          levelColors: levelColors,
          levelEmojis: levelEmojis,
        ) {
    // 初始化 _includeBox（与原始 PrettyPrinter 逻辑一致）
    _includeBox = {};
    for (var l in Level.values) {
      _includeBox[l] = !noBoxingByDefault;
    }
    excludeBox.forEach((k, v) => _includeBox[k] = !v);

    // 初始化中间分隔线
    var singleDividerLine = StringBuffer();
    for (var i = 0; i < _prettyPrinter.lineLength - 1; i++) {
      singleDividerLine.write(PrettyPrinter.singleDivider);
    }
    _middleBorder = '${PrettyPrinter.middleCorner}$singleDividerLine';
  }

  /// 判断是否为单行日志
  bool _isSingleLine(
    String message,
    String? error,
    String? stacktrace,
  ) {
    if (!enableSingleLineOptimization) return false;
    return !message.contains('\n') && message.length <= singleLineThreshold && error == null && stacktrace == null;
  }

  /// 生成带时间信息的顶部边框
  String _generateTopBorderWithTime(String time) {
    // 计算时间信息的长度
    var timeInfo = '[$time]';
    var timeInfoLength = timeInfo.length;

    // 使用用户设置的 lineLength
    var userLineLength = _prettyPrinter.lineLength - 1;
    var minTimeBorderLength = timeInfoLength + 4; // [时间] + ┌─ + ──
    var topBorderLength = userLineLength > minTimeBorderLength ? userLineLength : minTimeBorderLength;

    // 计算左右分隔符的长度
    var remainingLength = topBorderLength - timeInfoLength;
    var leftLength = (remainingLength - 2) ~/ 2;
    var rightLength = remainingLength - 2 - leftLength;

    var leftBorder = PrettyPrinter.topLeftCorner + PrettyPrinter.doubleDivider * leftLength;
    var rightBorder = PrettyPrinter.doubleDivider * rightLength;

    return '$leftBorder$timeInfo$rightBorder';
  }

  /// 生成普通顶部边框
  String _generateTopBorder() {
    var doubleDividerLine = StringBuffer();
    for (var i = 0; i < _prettyPrinter.lineLength - 1; i++) {
      doubleDividerLine.write(PrettyPrinter.doubleDivider);
    }
    return '${PrettyPrinter.topLeftCorner}$doubleDividerLine';
  }

  /// 生成底部边框（与顶部边框长度匹配）
  String _generateBottomBorder(String? time) {
    var doubleDividerLine = StringBuffer();

    // 如果有时间且嵌入边框，需要计算与顶部边框相同的长度
    int borderLength;
    if (embedTimeInBorder && time != null) {
      var timeInfo = '[$time]';
      var timeInfoLength = timeInfo.length;
      var userLineLength = _prettyPrinter.lineLength - 1;
      var minTimeBorderLength = timeInfoLength + 4;
      borderLength = userLineLength > minTimeBorderLength ? userLineLength : minTimeBorderLength;
    } else {
      borderLength = _prettyPrinter.lineLength - 1;
    }

    for (var i = 0; i < borderLength; i++) {
      doubleDividerLine.write(PrettyPrinter.doubleDivider);
    }
    return '${PrettyPrinter.bottomLeftCorner}$doubleDividerLine';
  }

  /// 获取 Emoji
  String _getEmoji(Level level) {
    if (!_prettyPrinter.printEmojis) return '';

    final String? emoji = _prettyPrinter.levelEmojis?[level] ?? PrettyPrinter.defaultLevelEmojis[level];
    if (emoji != null) {
      return '$emoji ';
    }
    return '';
  }

  /// 获取级别颜色
  AnsiColor _getLevelColor(Level level) {
    AnsiColor? color;
    if (_prettyPrinter.colors) {
      color = _prettyPrinter.levelColors?[level] ?? PrettyPrinter.defaultLevelColors[level];
    }
    return color ?? const AnsiColor.none();
  }

  @override
  List<String> log(LogEvent event) {
    var messageStr = _stringifyMessage(event.message);

    String? stackTraceStr;
    if (event.error != null) {
      if (_prettyPrinter.errorMethodCount == null || _prettyPrinter.errorMethodCount! > 0) {
        stackTraceStr = _prettyPrinter.formatStackTrace(
          event.stackTrace ?? StackTrace.current,
          _prettyPrinter.errorMethodCount,
        );
      }
    } else if (_prettyPrinter.methodCount == null || _prettyPrinter.methodCount! > 0) {
      stackTraceStr = _prettyPrinter.formatStackTrace(
        event.stackTrace ?? StackTrace.current,
        _prettyPrinter.methodCount,
      );
    }

    var errorStr = event.error?.toString();

    String? timeStr;
    if (_prettyPrinter.dateTimeFormat != DateTimeFormat.none) {
      timeStr = _prettyPrinter.getTime(event.time);
    }

    return _formatAndPrint(
      event.level,
      messageStr,
      timeStr,
      errorStr,
      stackTraceStr,
    );
  }

  /// 自定义格式化方法（基于原始 PrettyPrinter 的逻辑）
  List<String> _formatAndPrint(
    Level level,
    String message,
    String? time,
    String? error,
    String? stacktrace,
  ) {
    List<String> buffer = [];

    // 计算 verticalLineAtLevel（与原始逻辑一致）
    var verticalLineAtLevel = (_includeBox[level]!) ? ('${PrettyPrinter.verticalLine} ') : '';
    var color = _getLevelColor(level);

    // 判断是否为单行日志（新增功能）
    if (_isSingleLine(message, error, stacktrace)) {
      // 单行日志优化
      var emoji = _getEmoji(level);
      if (inlineTimeForSingleLine && time != null) {
        // 时间内联显示
        buffer.add(color('[$time] $emoji$message'));
      } else {
        // 普通单行显示
        buffer.add(color('$emoji$message'));
      }
      return buffer;
    }

    // 多行日志 - 按照原始顺序处理

    // 1. 顶部边框（可能嵌入时间）
    if (_includeBox[level]!) {
      if (embedTimeInBorder && time != null) {
        buffer.add(color(_generateTopBorderWithTime(time)));
      } else {
        buffer.add(color(_generateTopBorder()));
      }
    }

    // 2. error 部分（原始逻辑）
    if (error != null) {
      for (var line in error.split('\n')) {
        buffer.add(color('$verticalLineAtLevel$line'));
      }
      if (_includeBox[level]!) buffer.add(color(_middleBorder));
    }

    // 3. stacktrace 部分（原始逻辑）
    if (stacktrace != null) {
      for (var line in stacktrace.split('\n')) {
        buffer.add(color('$verticalLineAtLevel$line'));
      }
      if (_includeBox[level]!) buffer.add(color(_middleBorder));
    }

    // 4. time 部分（如果没有嵌入边框）
    if (time != null && !embedTimeInBorder) {
      buffer.add(color('$verticalLineAtLevel$time'));
      if (_includeBox[level]!) buffer.add(color(_middleBorder));
    }

    // 5. message 部分（原始逻辑 - emoji 在每一行都显示）
    var emoji = _getEmoji(level);
    for (var line in message.split('\n')) {
      buffer.add(color('$verticalLineAtLevel$emoji$line'));
    }

    // 6. 底部边框
    if (_includeBox[level]!) buffer.add(color(_generateBottomBorder(time)));

    return buffer;
  }

  /// 字符串化消息
  String _stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      var encoder = JsonEncoder.withIndent('  ', _toEncodableFallback);
      return encoder.convert(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }

  /// 处理无法编码的对象
  Object _toEncodableFallback(dynamic object) {
    return object.toString();
  }
}
