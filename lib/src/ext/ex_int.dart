import 'package:super_core/src/ext/ex_object.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description bool方法
///
extension IntExtension on int? {
  /// 为空时返回Obj
  int emptyToNew(int obj) => isEmptyOrNull ? obj : this!;

  /// 不为空时返回Obj
  int notEmptyToNew(int obj) => isNotEmptyOrNull ? obj : this!;

  /// string形式的bool值
  bool get boolValue => this != null && this == 1;

  /// 取反value
  int get reverseBoolInt => boolValue ? 0 : 1;
}
