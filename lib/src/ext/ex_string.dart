import 'dart:async';

import 'package:super_core/src/ext/ex_bool.dart';
import 'package:super_core/src/ext/ex_object.dart';
import 'package:super_core/src/utils/obj_util.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description String方法
///
extension StringExtension on String? {
  /// string形式的bool值
  bool getBool() => isEmptyOrNull && this == "1";

  /// string形式的int值
  int getBoolInt() => getBool().getIntValue();

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

  /// string形式的非bool的string
  String getReverseBoolStr() => getBool() ? "0" : "1";
}
