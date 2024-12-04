import 'dart:math';

import "package:path/path.dart" as path;

import '../../super_core.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description String方法
///
extension StringExtension on String? {
  /// 是否为null或空
  bool get isEmptyOrNull => ObjUtil.isEmpty(this);

  /// 是否不为null或空
  bool get isNotEmptyOrNull => ObjUtil.isNotEmpty(this);

  /// 为空时返回Obj
  String emptyToNew(String obj, {String prefix = "", String suffix = ""}) => isEmptyOrNull ? obj : "$prefix$this$suffix";

  /// 不为空时返回Obj
  String notEmptyToNew(String obj) => isNotEmptyOrNull ? obj : this!;

  /// string形式的bool值
  bool get boolValue => isNotEmptyOrNull && this == "1";

  /// string形式的int值
  int get intValue => boolValue.intValue;

  /// string形式的非bool的string
  String get reverseBoolStr => boolValue ? "0" : "1";

  /// string形式的int值
  int toInt({int defaultValue = 0}) {
    if (isEmptyOrNull) return defaultValue;
    return int.tryParse(this!) ?? defaultValue;
  }

  /// string形式的double值
  double toDouble({double defaultValue = 0.0}) {
    if (isEmptyOrNull) return defaultValue;
    return double.tryParse(this!) ?? defaultValue;
  }

  /// string转换为double-> 处理小数点
  String toAsFixed({double defaultValue = 0.0, int fractionDigits = 2}) {
    return toDouble(defaultValue: defaultValue).toStringAsFixed(fractionDigits);
  }

  /// 不为空是后面增加指定文本
  String notEmptySuffix(String suffix) {
    return isEmptyOrNull ? (this ?? '') : '$this$suffix';
  }

  /// 不为空是前面增加指定文本
  String notEmptyPrefix(String prefix) {
    return isEmptyOrNull ? (this ?? '') : '$prefix$this';
  }

  /// 获取后面的文本
  String lastStr({int number = 1}) {
    if (isEmptyOrNull) return "";
    return this!.substring(max(this!.length - number, 0));
  }

  /// 获取后面的文本
  String firstStr({int number = 1}) {
    if (isEmptyOrNull) return "";
    return this!.substring(0, min(this!.length, number));
  }

  /// 获取文件名称含后缀
  String fileNameAndExtension() => isNotEmptyOrNull ? path.basename(this!) : '';

  /// 获取文件名称
  String fileName() => isNotEmptyOrNull ? path.basenameWithoutExtension(this!) : '';

  /// string转日期
  DateTime? toDateTime({String format = DateEnum.normYmdHms}) => DateUtil.getTime(this, format: format);

  /// string转日期
  String? toStrTime({
    String srcFormat = DateEnum.normYmdHms,
    String destFormat = DateEnum.normYmd,
  }) =>
      DateUtil.dateStrToStr(this, srcFormat: srcFormat, destFormat: destFormat);
}
