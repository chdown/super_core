import 'package:flutter/widgets.dart';

/// 数字转 EdgeInsets 扩展
extension PaddingExtensions on num {
  /// 创建所有方向上偏移量相等的内边距
  /// 示例: 5.paddingAll() 等同于 EdgeInsets.all(5.0)
  EdgeInsets paddingAll() => EdgeInsets.all(toDouble());

  /// 创建水平方向上对称的内边距
  /// 示例: 5.paddingHorizontal() 等同于 EdgeInsets.symmetric(horizontal: 5.0)
  EdgeInsets paddingHorizontal() => EdgeInsets.symmetric(horizontal: toDouble());

  /// 创建垂直方向上对称的内边距
  /// 示例: 5.paddingVertical() 等同于 EdgeInsets.symmetric(vertical: 5.0)
  EdgeInsets paddingVertical() => EdgeInsets.symmetric(vertical: toDouble());

  /// 创建只有顶部内边距的 EdgeInsets
  /// 示例: 5.paddingTop() 等同于 EdgeInsets.only(top: 5.0)
  EdgeInsets paddingTop() => EdgeInsets.only(top: toDouble());

  /// 创建只有左侧内边距的 EdgeInsets
  /// 示例: 5.paddingLeft() 等同于 EdgeInsets.only(left: 5.0)
  EdgeInsets paddingLeft() => EdgeInsets.only(left: toDouble());

  /// 创建只有右侧内边距的 EdgeInsets
  /// 示例: 5.paddingRight() 等同于 EdgeInsets.only(right: 5.0)
  EdgeInsets paddingRight() => EdgeInsets.only(right: toDouble());

  /// 创建只有底部内边距的 EdgeInsets
  /// 示例: 5.paddingBottom() 等同于 EdgeInsets.only(bottom: 5.0)
  EdgeInsets paddingBottom() => EdgeInsets.only(bottom: toDouble());
}
