import 'dart:async';

import 'package:flutter/material.dart';
import 'package:super_core/src/utils/obj_util.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description context方法
///
extension ContextExtension on BuildContext {

  Size size() => MediaQuery.sizeOf(this);

  double get width => size().width;

  double get height => size().height;

  EdgeInsets _padding() => MediaQuery.paddingOf(this);

  double get statusBarHeight => _padding().top;

  double get navigationBarHeight => _padding().bottom;

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme =>theme.colorScheme;

  Color get primary =>colorScheme.primary;
}
