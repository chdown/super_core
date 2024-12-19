import 'package:flutter/widgets.dart';

/// @author : ch
/// @date 2024-12-19 09:37:13
/// @description Sliver扩展
///
extension ExSliver on Widget {
  /// SliverToBoxAdapter
  Widget sliverToBoxAdapter({Key? key}) => SliverToBoxAdapter(key: key, child: this);

  /// 内间距
  Widget sliverPadding({
    Key? key,
    EdgeInsetsGeometry? value,
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) =>
      SliverPadding(
        key: key,
        padding: value ??
            EdgeInsets.only(
              top: top ?? vertical ?? all ?? 0.0,
              bottom: bottom ?? vertical ?? all ?? 0.0,
              left: left ?? horizontal ?? all ?? 0.0,
              right: right ?? horizontal ?? all ?? 0.0,
            ),
        sliver: this,
      );

  /// 内间距 下
  Widget sliverPaddingBottom(double val) => sliverPadding(bottom: val);

  /// 内间距 横向
  Widget sliverPaddingHorizontal(double val) => sliverPadding(horizontal: val);

  /// 内间距 左
  Widget sliverPaddingLeft(double val) => sliverPadding(left: val);

  /// 内间距 右
  Widget sliverPaddingRight(double val) => sliverPadding(right: val);

  /// 内间距 上
  Widget sliverPaddingTop(double val) => sliverPadding(top: val);

  /// 内间距 纵向
  Widget sliverPaddingVertical(double val) => sliverPadding(vertical: val);
}
