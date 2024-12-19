import 'package:flutter/widgets.dart';

/// @author : ch
/// @date 2024-12-19 09:37:13
/// @description Clip扩展
///
extension ExClip on Widget {
  /// 裁剪 oval
  Widget clipOval({Key? key}) => ClipOval(
        key: key,
        child: this,
      );

  /// 裁剪 rect
  Widget clipRect({
    Key? key,
    CustomClipper<Rect>? clipper,
    Clip clipBehavior = Clip.hardEdge,
  }) =>
      ClipRect(
        key: key,
        clipper: clipper,
        clipBehavior: clipBehavior,
        child: this,
      );

  /// 裁剪圆角
  Widget clipRRect({
    Key? key,
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    CustomClipper<RRect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) =>
      ClipRRect(
        key: key,
        clipper: clipper,
        clipBehavior: clipBehavior,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft ?? all ?? 0.0),
          topRight: Radius.circular(topRight ?? all ?? 0.0),
          bottomLeft: Radius.circular(bottomLeft ?? all ?? 0.0),
          bottomRight: Radius.circular(bottomRight ?? all ?? 0.0),
        ),
        child: this,
      );
}
