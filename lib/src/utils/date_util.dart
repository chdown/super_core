import 'package:intl/intl.dart';
import 'package:super_core/src/utils/enum/date_enum.dart';
import 'package:super_core/src/utils/obj_util.dart';

/// @author : ch
/// @date 2024-03-12 16:16:44
/// @description 日期工具
///
class DateUtil {
  DateUtil._();

  /// 获取日期
  static String getNowDateStr({String format = DateEnum.normYmd}) => dateToStr(DateTime.now(), format: format);

  /// 获取当前日期的dateTime
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
    } catch (ex) {
      return _getCompatibleTime(time!, format);
    }
  }

  /// 兼容性处理方案
  static DateTime? _getCompatibleTime(String time, String format) {
    if (RegExp('^[0-9]+年[0-9]+月[0-9]+日 [0-9]+时[0-9]+分[0-9]+秒\$').hasMatch(time)) {
      format = "yyyy年MM月dd日 HH时mm分ss秒";
    } else if (RegExp('^[0-9]+-[0-9]+-[0-9]+ [0-9]+:[0-9]+:[0-9]+\$').hasMatch(time)) {
      format = "yyyy-MM-dd HH:mm:ss";
    } else if (RegExp('^[0-9]+年[0-9]+月[0-9]+日\$').hasMatch(time)) {
      format = "yyyy年MM月dd日";
    } else if (RegExp('^[0-9]+-[0-9]+-[0-9]+\$').hasMatch(time)) {
      format = "yyyy-MM-dd";
    } else if (RegExp('^[0-9]+年[0-9]+月\$').hasMatch(time)) {
      format = "yyyy年MM月";
    } else if (RegExp('^[0-9]+-[0-9]+\$').hasMatch(time)) {
      format = "yyyy-MM";
    } else if (RegExp('^[0-9]+时[0-9]+分[0-9]+秒\$').hasMatch(time)) {
      format = "HH时mm分ss秒";
    } else if (RegExp('^[0-9]+:[0-9]+:[0-9]+\$').hasMatch(time)) {
      format = "HH:mm:ss";
    } else if (RegExp('^[0-9]+时[0-9]+分\$').hasMatch(time)) {
      format = "HH时mm分";
    } else if (RegExp('^[0-9]+:[0-9]+\$').hasMatch(time)) {
      format = "HH:mm";
    }
    try {
      return DateFormat(format).parse(time);
    } catch (ex) {
      return null;
    }
  }
}
