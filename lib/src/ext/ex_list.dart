import 'dart:async';

import 'package:flutter/material.dart';
import 'package:super_core/src/utils/obj_util.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description Iterable方法
///
extension ListExt<T> on List<T> {
  bool firstWhereOrNullBool(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return true;
    }
    return false;
  }
}