import 'package:super_core/src/ext/ex_bool.dart';
import 'package:super_core/src/ext/ex_object.dart';
import 'package:super_core/src/utils/obj_util.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description String方法
///
extension StringExtension on String? {

  /// 为空时返回Obj
  String emptyToNew(String obj) => isEmptyOrNull ? obj : this!;

  /// 不为空时返回Obj
  String notEmptyToNew(String obj) => isNotEmptyOrNull ? obj : this!;

  /// string形式的bool值
  bool get boolValue => isEmptyOrNull && this == "1";

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

  /// 不为空是后面增加指定文本
  String notEmptySuffix(String suffix) {
    return isEmptyOrNull ? (this ?? '') : '$this$suffix';
  }

  /// 不为空是前面增加指定文本
  String notEmptyPrefix(String prefix) {
    return isEmptyOrNull ? (this ?? '') : '$prefix$this';
  }
}
