import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:super_core/src/utils/click_throttler_utils.dart';
import 'package:super_core/super_core.dart';

/// @author : ch
/// @date 2024-12-19 09:37:13
/// @description Align扩展
///
extension ExGesture on Widget {
  /// 墨水纹
  /// [debounceTime] 为0时取消节流
  Widget inkWell({
    Key? key,
    Function()? onTap,
    Function()? onLongPress,
    double? borderRadius,
    int? debounceTime,
  }) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          borderRadius: borderRadius != null ? BorderRadius.all(Radius.circular(borderRadius)) : null,
          onTap: onTap == null
              ? null
              : () {
                  if (!ClickThrottlerUtils.canClick(Duration(milliseconds: debounceTime ?? SuperConfig.debounceTime))) return;
                  onTap.call();
                },
          onLongPress: onLongPress,
          child: this,
        ),
      ),
    );
  }

  /// 手势
  Widget onTap(
    GestureTapCallback? onTap, {
    Key? key,
    GestureLongPressCallback? onLongPress,
    HitTestBehavior? behavior,
    bool excludeFromSemantics = false,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    int? debounceTime,
  }) {
    return GestureDetector(
      key: key,
      onLongPress: onLongPress,
      onTap: onTap == null
          ? null
          : () {
              if (!ClickThrottlerUtils.canClick(Duration(milliseconds: debounceTime ?? SuperConfig.debounceTime))) return;
              onTap.call();
            },
      behavior: behavior ?? HitTestBehavior.opaque,
      excludeFromSemantics: excludeFromSemantics,
      dragStartBehavior: dragStartBehavior,
      child: this,
    );
  }

  /// 长按手势
  Widget onLongPress(
    GestureTapCallback? onLongPress, {
    Key? key,
    HitTestBehavior? behavior,
    bool excludeFromSemantics = false,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
  }) =>
      GestureDetector(
        key: key,
        onLongPress: onLongPress,
        behavior: behavior ?? HitTestBehavior.opaque,
        excludeFromSemantics: excludeFromSemantics,
        dragStartBehavior: dragStartBehavior,
        child: this,
      );

  /// 涟漪
  Widget ripple({
    Key? key,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    InteractiveInkFeatureFactory? splashFactory,
    double? radius,
    ShapeBorder? customBorder,
    bool enableFeedback = true,
    bool excludeFromSemantics = false,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    bool autoFocus = false,
    bool enable = true,
  }) =>
      !enable
          ? Builder(key: key, builder: (context) => this)
          : Builder(
              key: key,
              builder: (BuildContext context) {
                GestureDetector? gestures = context.findAncestorWidgetOfExactType<GestureDetector>();
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: focusColor,
                    hoverColor: hoverColor,
                    highlightColor: highlightColor,
                    splashColor: splashColor,
                    splashFactory: splashFactory,
                    radius: radius,
                    customBorder: customBorder,
                    enableFeedback: enableFeedback,
                    excludeFromSemantics: excludeFromSemantics,
                    focusNode: focusNode,
                    canRequestFocus: canRequestFocus,
                    autofocus: autoFocus,
                    onTap: gestures?.onTap,
                    child: this,
                  ),
                );
              },
            );
}
