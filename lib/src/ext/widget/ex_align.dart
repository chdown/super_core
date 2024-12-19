import 'package:flutter/widgets.dart';

/// @author : ch
/// @date 2024-12-19 09:37:13
/// @description Align扩展
///
extension ExAlign on Widget {
  /// 对齐
  Widget align(AlignmentGeometry alignment, {Key? key}) => Align(key: key, alignment: alignment, child: this);

  /// 对齐 中间
  Widget alignCenter() => align(Alignment.center);

  /// 对齐 左边
  Widget alignLeft() => align(Alignment.centerLeft);

  /// 对齐 右边
  Widget alignRight() => align(Alignment.centerRight);

  /// 对齐 顶部
  Widget alignTop() => align(Alignment.topCenter);

  /// 对齐 底部
  Widget alignBottom() => align(Alignment.bottomCenter);

  /// 居中
  Widget center({Key? key, double? widthFactor, double? heightFactor}) => Center(key: key, widthFactor: widthFactor, heightFactor: heightFactor, child: this);
}
