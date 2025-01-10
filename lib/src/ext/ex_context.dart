import 'package:flutter/material.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description context方法
///
extension ContextExtension on BuildContext {
  EdgeInsets _padding() => MediaQuery.paddingOf(this);

  /// 各种尺寸信息
  Size size() => MediaQuery.sizeOf(this);

  /// 获取主题颜色
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// 获取屏幕宽度
  /// 返回: 当前上下文的屏幕宽度
  double get sizeWidth => size().width;

  /// 获取屏幕高度
  /// 返回: 当前上下文的屏幕高度
  double get sizeHeight => size().height;

  /// 获取状态栏高度
  double get statusBarHeight => _padding().top;

  /// 获取底部导航栏高度
  double get bottomBarHeight => _padding().bottom;

  /// 获取键盘高度
  double get viewInsetsBottom => MediaQuery.viewInsetsOf(this).bottom;

  /// 获取当前屏幕方向
  Orientation get orientation => MediaQuery.of(this).orientation;

  /// 判断是否为横屏模式
  bool get isLandscape => orientation == Orientation.landscape;

  /// 判断是否为竖屏模式
  bool get isPortrait => orientation == Orientation.portrait;
}
