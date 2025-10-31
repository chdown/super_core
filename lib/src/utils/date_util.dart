import 'package:intl/intl.dart';
import 'package:super_core/src/utils/enum/date_enum.dart';
import 'package:super_core/src/utils/obj_util.dart';

/// @author : ch
/// @date 2024-03-12 16:16:44
/// @description 日期工具类
/// 支持多种日期格式的解析和转换
/// 包括：标准日期时间、ISO格式、中文格式等
class DateUtil {
  DateUtil._();

  /// 时间戳有效范围（1900-2100年）
  static const int _minTimestampSeconds = -2208988800; // 1900-01-01
  static const int _maxTimestampSeconds = 4102444800; // 2100-01-01
  static const int _minTimestampMillis = -2208988800000;
  static const int _maxTimestampMillis = 4102444800000;

  /// 获取当前日期字符串
  /// [format] 默认：yyyy-MM-dd
  static String getNowDateStr({String format = DateEnum.normYmd}) => dateToStr(DateTime.now(), format: format);

  /// 获取当前日期时间（截断精度，用于时间比较）
  /// 例如：使用 yyyy-MM-dd 格式获取当天 00:00:00
  /// [format] 默认：yyyy-MM-dd HH:mm:ss
  static DateTime getNowTime({String format = DateEnum.normYmdHms}) => DateFormat(format).parse(getNowDateStr(format: format));

  /// DateTime 转字符串
  /// [format] 默认：yyyy-MM-dd
  static String dateToStr(DateTime? dateTime, {String format = DateEnum.normYmd}) {
    if (dateTime == null) return "";
    return DateFormat(format).format(dateTime);
  }

  /// 字符串日期转换格式
  /// [srcFormat] 源格式，默认：yyyy-MM-dd HH:mm:ss
  /// [destFormat] 目标格式，默认：yyyy-MM-dd
  static String dateStrToStr(
    String? srcTime, {
    String srcFormat = DateEnum.normYmdHms,
    String destFormat = DateEnum.normYmd,
  }) {
    if (ObjUtil.isEmpty(srcTime)) return "";
    return dateToStr(getTime(srcTime, format: srcFormat), format: destFormat);
  }

  /// 日期转换（截断精度）
  /// 通过格式化实现精度截断
  /// [srcFormat] 源格式，默认：yyyy-MM-dd HH:mm:ss
  /// [destFormat] 目标格式，默认：yyyy-MM-dd
  static DateTime? dateToDate(
    DateTime srcTime, {
    String srcFormat = DateEnum.normYmdHms,
    String destFormat = DateEnum.normYmd,
  }) {
    return getTime(dateToStr(srcTime, format: srcFormat), format: destFormat);
  }

  /// 字符串转 DateTime
  /// 支持自动识别多种格式（包括时间戳）
  /// [format] 默认：yyyy-MM-dd HH:mm:ss
  static DateTime? getTime(String? time, {String format = DateEnum.normYmdHms}) {
    if (ObjUtil.isEmpty(time)) return null;
    try {
      return DateFormat(format).parse(time!);
    } catch (e) {
      return _getCompatibleTime(time!, format);
    }
  }

  /// 日期格式自动匹配规则（使用标准分隔符 - 定义模式）
  /// 支持自动识别并转换 -、/、. 三种分隔符
  static final Map<RegExp, String> _datePatterns = {
    // 标准日期时间格式（支持 -、/、. 分隔符）
    RegExp(r'^\d{4}[-/\.]\d{1,2}[-/\.]\d{1,2} \d{1,2}:\d{1,2}:\d{1,2}$'): "yyyy-MM-dd HH:mm:ss",
    RegExp(r'^\d{4}年\d{1,2}月\d{1,2}日 \d{1,2}时\d{1,2}分\d{1,2}秒$'): "yyyy年MM月dd日 HH时mm分ss秒",

    // 标准日期格式（支持 -、/、. 分隔符）
    RegExp(r'^\d{4}[-/\.]\d{1,2}[-/\.]\d{1,2}$'): "yyyy-MM-dd",
    RegExp(r'^\d{4}年\d{1,2}月\d{1,2}日$'): "yyyy年MM月dd日",

    // 时间格式（24小时制）
    RegExp(r'^\d{1,2}:\d{1,2}:\d{1,2}$'): "HH:mm:ss",
    RegExp(r'^\d{1,2}时\d{1,2}分\d{1,2}秒$'): "HH时mm分ss秒",
    RegExp(r'^\d{1,2}:\d{1,2}$'): "HH:mm",
    RegExp(r'^\d{1,2}时\d{1,2}分$'): "HH时mm分",

    // 年月格式（支持 -、/、. 分隔符）
    RegExp(r'^\d{4}[-/\.]\d{1,2}$'): "yyyy-MM",
    RegExp(r'^\d{4}年\d{1,2}月$'): "yyyy年MM月",

    // 月日格式（支持 -、/、. 分隔符）
    RegExp(r'^\d{1,2}[-/\.]\d{1,2}$'): "MM-dd",
    RegExp(r'^\d{1,2}月\d{1,2}日$'): "MM月dd日",

    // 带毫秒的时间格式
    RegExp(r'^\d{1,2}:\d{1,2}:\d{1,2}\.\d{3}$'): "HH:mm:ss.SSS",
    RegExp(r'^\d{1,2}时\d{1,2}分\d{1,2}秒\d{3}毫秒$'): "HH时mm分ss秒SSS毫秒",

    // 时间格式（12小时制）
    RegExp(r'^\d{1,2}:\d{1,2}:\d{1,2} [AaPp][Mm]$'): "hh:mm:ss a",
    RegExp(r'^\d{1,2}:\d{1,2} [AaPp][Mm]$'): "hh:mm a",
    RegExp(r'^\d{1,2}时\d{1,2}分\d{1,2}秒 (?:上午|下午)$'): "hh时mm分ss秒 a",
    RegExp(r'^\d{1,2}时\d{1,2}分 (?:上午|下午)$'): "hh时mm分 a",

    // ISO 8601 格式（带毫秒）
    RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$'): "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
    RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}$'): "yyyy-MM-dd'T'HH:mm:ss.SSS",

    // ISO 8601 格式（不带毫秒）
    RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$'): "yyyy-MM-dd'T'HH:mm:ss'Z'",
    RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$'): "yyyy-MM-dd'T'HH:mm:ss",

    // ISO 8601 带时区偏移
    RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}[+-]\d{2}:?\d{2}$'): "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
    RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}[+-]\d{2}:?\d{2}$'): "yyyy-MM-dd'T'HH:mm:ssZ",
  };

  /// 兼容性处理：自动识别时间戳（10位/13位）和多种日期格式
  /// 时间戳转换为本地时间
  static DateTime? _getCompatibleTime(String time, String format) {
    // 处理时间戳（秒）
    if (RegExp(r'^-?\d{10}$').hasMatch(time)) {
      try {
        final timestamp = int.parse(time);
        if (timestamp < _minTimestampSeconds || timestamp > _maxTimestampSeconds) return null;
        return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: false);
      } catch (e) {
        return null;
      }
    }

    // 处理时间戳（毫秒）
    if (RegExp(r'^-?\d{13}$').hasMatch(time)) {
      try {
        final timestamp = int.parse(time);
        if (timestamp < _minTimestampMillis || timestamp > _maxTimestampMillis) return null;
        return DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: false);
      } catch (e) {
        return null;
      }
    }

    // 尝试自动匹配格式
    for (var entry in _datePatterns.entries) {
      if (entry.key.hasMatch(time)) {
        try {
          // 统一分隔符：将 / 和 . 替换为标准的 -
          String normalizedTime = time;

          if (time.contains('/')) {
            // 替换斜杠为横杠
            normalizedTime = time.replaceAll('/', '-');
          } else if (time.contains('.')) {
            // 判断点是日期分隔符还是时间毫秒
            // 日期分隔符：yyyy.MM.dd 或 yyyy.MM.dd HH:mm:ss
            // 时间毫秒：HH:mm:ss.SSS（点后面正好3位数字，且可能跟着Z或时区）
            if (RegExp(r'\.\d{3}([Z+\-]|$)').hasMatch(time)) {
              // 包含毫秒格式（.SSS 结尾或后跟 Z/时区），不替换
            } else if (time.contains(' ')) {
              // 包含空格，说明是 "日期 时间" 格式，只替换日期部分的点
              final parts = time.split(' ');
              parts[0] = parts[0].replaceAll('.', '-');
              normalizedTime = parts.join(' ');
            } else {
              // 纯日期格式，替换所有点
              normalizedTime = time.replaceAll('.', '-');
            }
          }

          return DateFormat(entry.value).parse(normalizedTime);
        } catch (e) {
          continue;
        }
      }
    }
    return null;
  }

  // ============ UTC 时间处理 ============

  /// 获取当前 UTC 时间字符串
  /// [format] 默认：ISO 8601 格式
  static String getNowDateStrUtc({String format = DateEnum.iso8601}) {
    return dateToStr(DateTime.now().toUtc(), format: format);
  }

  /// 获取当前 UTC 时间
  static DateTime getNowTimeUtc() {
    return DateTime.now().toUtc();
  }

  /// 本地时间转 UTC
  static DateTime toUtc(DateTime localTime) {
    return localTime.toUtc();
  }

  /// UTC 转本地时间
  static DateTime toLocal(DateTime utcTime) {
    return utcTime.toLocal();
  }

  /// UTC 时间转字符串
  /// [format] 默认：ISO 8601 格式（带Z后缀）
  static String utcToStr(DateTime? utcTime, {String format = DateEnum.iso8601}) {
    if (utcTime == null) return "";
    return dateToStr(utcTime.toUtc(), format: format);
  }
}
