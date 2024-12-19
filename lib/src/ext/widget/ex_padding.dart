import 'package:flutter/widgets.dart';

/// @author : ch
/// @date 2024-12-19 09:37:13
/// @description Padding扩展
///
extension ExPadding on Widget {
  /// 内间距
  Widget padding({
    Key? key,
    EdgeInsetsGeometry? value,
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Padding(
      key: key,
      padding: value ??
          EdgeInsets.only(
            top: top ?? vertical ?? all ?? 0.0,
            bottom: bottom ?? vertical ?? all ?? 0.0,
            left: left ?? horizontal ?? all ?? 0.0,
            right: right ?? horizontal ?? all ?? 0.0,
          ),
      child: this,
    );
  }

  /// 内间距 全
  Widget paddingAll(double val) => padding(all: val);

  /// 内间距 下
  Widget paddingBottom(double val) => padding(bottom: val);

  /// 内间距 横向
  Widget paddingHorizontal(double val) => padding(horizontal: val);

  /// 内间距 左
  Widget paddingLeft(double val) => padding(left: val);

  /// 内间距 右
  Widget paddingRight(double val) => padding(right: val);

  /// 内间距 上
  Widget paddingTop(double val) => padding(top: val);

  /// 内间距 纵向
  Widget paddingVertical(double val) => padding(vertical: val);
}
