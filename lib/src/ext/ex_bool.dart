import 'dart:async';

import 'package:super_core/src/utils/obj_util.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description bool方法
///
extension BoolExtension on bool? {

  /// 取value
  int getIntValue() {
    if (this == null) return 0;
    return this! ? 1 : 0;
  }

  /// 取value
  String getStringValue() => getIntValue().toString();

  /// 取反value
  int getReverseIntValue() {
    if (this == null) return 1;
    return this! ? 0 : 1;
  }

  /// 取value
  String getReverseIntStringValue() => getReverseIntValue().toString();
}
