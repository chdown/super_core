import 'package:intl/intl.dart';
import 'package:super_core/src/utils/enum/date_enum.dart';
import 'package:super_core/src/utils/obj_util.dart';

/// @author : ch
/// @date 2024-03-12 16:16:44
/// @description 日期工具
///
class DateUtil {
  DateUtil._();

  /// 获取当前日期字符串
  static String getNowDateStr({String format = DateEnum.normYmd}) => dateToStr(DateTime.now(), format: format);

  /// 获取当前日期时间
  static DateTime getNowTime({String format = DateEnum.normYmdHms}) => DateFormat(format).parse(getNowDateStr(format: format));

  /// DateTime日期转换为字符串日期
  static String dateToStr(DateTime? dateTime, {String format = DateEnum.normYmd}) {
    if (dateTime == null) return "";
    return DateFormat(format).format(dateTime);
  }

  /// 字符串日期转换为字符串日期
  static String dateStrToStr(
    String? srcTime, {
    String srcFormat = DateEnum.normYmdHms,
    String destFormat = DateEnum.normYmd,
  }) {
    if (ObjUtil.isEmpty(srcTime)) return "";
    return dateToStr(getTime(srcTime, format: srcFormat), format: destFormat);
  }

  /// 日期转换为新日期
  static DateTime? dateToDate(
    DateTime srcTime, {
    String srcFormat = DateEnum.normYmdHms,
    String destFormat = DateEnum.normYmd,
  }) {
    return getTime(dateToStr(srcTime, format: srcFormat), format: destFormat);
  }

  /// 获取时间
  static DateTime? getTime(String? time, {String format = DateEnum.normYmdHms}) {
    if (ObjUtil.isEmpty(time)) return null;
    try {
      return DateFormat(format).parse(time!);
    } catch (e) {
      return _getCompatibleTime(time!, format);
    }
  }

  /// 日期格式匹配规则
  static final Map<RegExp, String> _datePatterns = {
    // 标准日期时间格式
    RegExp(r'^\d{4}年\d{1,2}月\d{1,2}日 \d{1,2}时\d{1,2}分\d{1,2}秒$'): "yyyy年MM月dd日 HH时mm分ss秒",
    RegExp(r'^\d{4}-\d{1,2}-\d{1,2} \d{1,2}:\d{1,2}:\d{1,2}$'): "yyyy-MM-dd HH:mm:ss",
    RegExp(r'^\d{4}/\d{1,2}/\d{1,2} \d{1,2}:\d{1,2}:\d{1,2}$'): "yyyy/MM/dd HH:mm:ss",
    RegExp(r'^\d{4}\.\d{1,2}\.\d{1,2} \d{1,2}:\d{1,2}:\d{1,2}$'): "yyyy.MM.dd HH:mm:ss",

    // 标准日期格式
    RegExp(r'^\d{4}年\d{1,2}月\d{1,2}日$'): "yyyy年MM月dd日",
    RegExp(r'^\d{4}-\d{1,2}-\d{1,2}$'): "yyyy-MM-dd",
    RegExp(r'^\d{4}/\d{1,2}/\d{1,2}$'): "yyyy/MM/dd",
    RegExp(r'^\d{4}\.\d{1,2}\.\d{1,2}$'): "yyyy.MM.dd",

    // 年月格式
    RegExp(r'^\d{4}年\d{1,2}月$'): "yyyy年MM月",
    RegExp(r'^\d{4}-\d{1,2}$'): "yyyy-MM",
    RegExp(r'^\d{4}/\d{1,2}$'): "yyyy/MM",

    // 时间格式
    RegExp(r'^\d{1,2}时\d{1,2}分\d{1,2}秒$'): "HH时mm分ss秒",
    RegExp(r'^\d{1,2}:\d{1,2}:\d{1,2}$'): "HH:mm:ss",
    RegExp(r'^\d{1,2}时\d{1,2}分$'): "HH时mm分",
    RegExp(r'^\d{1,2}:\d{1,2}$'): "HH:mm",

    // 带毫秒的时间格式
    RegExp(r'^\d{1,2}:\d{1,2}:\d{1,2}\.\d{3}$'): "HH:mm:ss.SSS",
    RegExp(r'^\d{1,2}时\d{1,2}分\d{1,2}秒\d{3}毫秒$'): "HH时mm分ss秒SSS毫秒",
  };

  /// 兼容性处理方案
  static DateTime? _getCompatibleTime(String time, String format) {
    if (time.isEmpty) return null;

    // 处理时间戳
    if (RegExp(r'^-?\d{10}$').hasMatch(time)) {
      try {
        final timestamp = int.parse(time);
        return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      } catch (e) {
        return null;
      }
    }
    if (RegExp(r'^-?\d{13}$').hasMatch(time)) {
      try {
        final timestamp = int.parse(time);
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      } catch (e) {
        return null;
      }
    }

    // 处理标准日期格式
    for (var entry in _datePatterns.entries) {
      if (entry.key.hasMatch(time)) {
        try {
          return DateFormat(entry.value).parse(time);
        } catch (e) {
          continue;
        }
      }
    }

    // 尝试使用传入的格式解析
    try {
      return DateFormat(format).parse(time);
    } catch (e) {
      return null;
    }
  }
}
