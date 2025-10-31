/// @author : ch
/// @date 2024-03-12 13:34:18
/// @description 日期格式枚举类
///
/// 包含常用的日期时间格式定义，支持：
/// - 标准格式（横杠分隔）
/// - 中文格式
/// - ISO 8601/UTC 格式
/// - 多种分隔符格式（斜杠、点、紧凑）
/// - 12小时制格式
/// - 带星期格式
class DateEnum {
  DateEnum._();

  // ============ 标准格式（横杠分隔）============

  /// 年: 2025
  static const String normY = "yyyy";

  /// 年月: 2025-10
  static const String normYm = "yyyy-MM";

  /// 年月日: 2025-10-31
  static const String normYmd = "yyyy-MM-dd";

  /// 月日: 10-31
  static const String normMd = "MM-dd";

  /// 年月日时: 2025-10-31 18
  static const String normYmdH = "yyyy-MM-dd HH";

  /// 年月日时分: 2025-10-31 18:30
  static const String normYmdHm = "yyyy-MM-dd HH:mm";

  /// 年月日时分秒: 2025-10-31 18:30:00
  static const String normYmdHms = "yyyy-MM-dd HH:mm:ss";

  /// 时分: 18:30
  static const String normHm = "HH:mm";

  /// 时分秒: 18:30:00
  static const String normHms = "HH:mm:ss";

  // ============ 中文格式 ============

  /// 年: 2025年
  static const String chineseY = "yyyy年";

  /// 年月: 2025年10月
  static const String chineseYm = "yyyy年MM月";

  /// 年月日: 2025年10月31日
  static const String chineseYmd = "yyyy年MM月dd日";

  /// 月日: 10月31日
  static const String chineseMd = "MM月dd日";

  /// 年月日时: 2025年10月31日 18时
  static const String chineseYmdH = "yyyy年MM月dd日 HH时";

  /// 年月日时分: 2025年10月31日 18时30分
  static const String chineseYmdHm = "yyyy年MM月dd日 HH时mm分";

  /// 年月日时分秒: 2025年10月31日 18时30分00秒
  static const String chineseYmdHms = "yyyy年MM月dd日 HH时mm分ss秒";

  /// 时分: 18时30分
  static const String chineseHm = "HH时mm分";

  /// 时分秒: 18时30分00秒
  static const String chineseHms = "HH时mm分ss秒";

  // ============ 带毫秒格式 ============

  /// 年月日时分秒毫秒（标准）: 2025-10-31 18:30:00.123
  static const String normYmdHmsS = "yyyy-MM-dd HH:mm:ss.SSS";

  /// 时分秒毫秒: 18:30:00.123
  static const String normHmsS = "HH:mm:ss.SSS";

  /// 年月日时分秒毫秒（中文）: 2025年10月31日 18时30分00秒123毫秒
  static const String chineseYmdHmsS = "yyyy年MM月dd日 HH时mm分ss秒SSS毫秒";

  /// 月日时分（中文）: 10月31日 18:30
  static const String chineseMdHm = "MM月dd日 HH:mm";

  // ============ ISO 8601 / UTC 国际标准格式 ============

  /// ISO 8601 标准格式（UTC时区，以Z结尾）
  /// 示例: 2025-10-31T10:30:00Z
  /// 用途: API 接口、国际化应用、数据库存储
  static const String iso8601 = "yyyy-MM-dd'T'HH:mm:ss'Z'";

  /// ISO 8601 带毫秒格式（UTC时区）
  /// 示例: 2025-10-31T10:30:00.123Z
  /// 用途: 高精度时间记录、日志系统
  static const String iso8601Ms = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

  /// ISO 8601 带时区偏移格式
  /// 示例: 2025-10-31T10:30:00+08:00
  /// 用途: 需要明确时区信息的场景
  static const String iso8601Tz = "yyyy-MM-dd'T'HH:mm:ssZ";

  /// RFC 3339 格式（带毫秒和时区）
  /// 示例: 2025-10-31T10:30:00.123+08:00
  /// 用途: 互联网标准、REST API
  static const String rfc3339 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";

  // ============ 斜杠分隔格式（适用于美国等地区）============

  /// 年月（斜杠）: 2025/10
  static const String slashYm = "yyyy/MM";

  /// 年月日（斜杠）: 2025/10/31
  static const String slashYmd = "yyyy/MM/dd";

  /// 月日（斜杠）: 10/31
  static const String slashMd = "MM/dd";

  /// 年月日时分（斜杠）: 2025/10/31 18:30
  static const String slashYmdHm = "yyyy/MM/dd HH:mm";

  /// 年月日时分秒（斜杠）: 2025/10/31 18:30:00
  static const String slashYmdHms = "yyyy/MM/dd HH:mm:ss";

  // ============ 点分隔格式（适用于德国等欧洲地区）============

  /// 年月（点分隔）: 2025.10
  static const String dotYm = "yyyy.MM";

  /// 年月日（点分隔）: 2025.10.31
  static const String dotYmd = "yyyy.MM.dd";

  /// 月日（点分隔）: 10.31
  static const String dotMd = "MM.dd";

  /// 年月日时分（点分隔）: 2025.10.31 18:30
  static const String dotYmdHm = "yyyy.MM.dd HH:mm";

  /// 年月日时分秒（点分隔）: 2025.10.31 18:30:00
  static const String dotYmdHms = "yyyy.MM.dd HH:mm:ss";

  // ============ 紧凑格式（无分隔符，用于文件名、编号等）============

  /// 紧凑年月: 202510
  /// 用途: 月度文件归档、报表编号
  static const String compactYm = "yyyyMM";

  /// 紧凑年月日: 20251031
  /// 用途: 文件名、日志文件、批次号
  static const String compactYmd = "yyyyMMdd";

  /// 紧凑年月日时分秒: 20251031183000
  /// 用途: 唯一标识符、交易流水号
  static const String compactYmdHms = "yyyyMMddHHmmss";

  /// 紧凑时分秒: 183000
  /// 用途: 时间片段标记
  static const String compactHms = "HHmmss";

  // ============ 12小时制格式（AM/PM）============

  /// 12小时制时分: 06:30 PM
  /// 用途: 用户界面显示、英文环境
  static const String time12Hm = "hh:mm a";

  /// 12小时制时分秒: 06:30:00 PM
  static const String time12Hms = "hh:mm:ss a";

  /// 年月日+12小时制: 2025-10-31 06:30 PM
  static const String normYmdTime12 = "yyyy-MM-dd hh:mm a";

  // ============ 带星期格式（用于日历、日程显示）============

  /// 年月日+星期简写: 2025-10-31 周五
  /// 用途: 日历视图、待办事项
  static const String normYmdE = "yyyy-MM-dd E";

  /// 年月日+星期全称（中文）: 2025年10月31日 星期五
  /// 用途: 正式文档、通知公告
  static const String chineseYmdE = "yyyy年MM月dd日 EEEE";
}
