import 'package:flutter/material.dart';

/// 数字转 SizedBox 扩展
extension SizedBoxExtensions on num {
  /// 创建具有指定宽度的 SizedBox
  /// 示例: 10.horizontalSpace 创建一个宽度为 10 的 SizedBox
  SizedBox get hSizeBox => SizedBox(width: toDouble());

  /// 创建具有指定高度的 SizedBox
  /// 示例: 20.verticalSpace 创建一个高度为 20 的 SizedBox
  SizedBox get vSizeBox => SizedBox(height: toDouble());
}
