import 'dart:async';

import 'package:super_core/src/utils/obj_util.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description String方法
///
extension StringExtension on String? {
  String inversionValue() {
    if (this == null) return "1";
    return this == "0" ? "1" : "0";
  }
}
