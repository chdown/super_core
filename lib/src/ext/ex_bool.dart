import 'dart:async';

import 'package:super_core/src/utils/object_util.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description bool方法
///
extension BoolExtension on bool? {

  /// 取value
  int value() {
    if (this == null) return 0;
    return this! ? 1 : 0;
  }

  /// 取反value
  int inversionValue() {
    if (this == null) return 1;
    return this! ? 1 : 1;
  }
}