import 'dart:async';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description 防抖节流方法
///

typedef StringCallback = void Function(String value);

typedef IntCallback = void Function(int value);

extension ExExtension on Function()? {
  /// 扩展Function，添加防抖功能
  /// 正确：当事件在设定的时间内没有再次触发时，才会执行相应的函数
  /// 此处：一定时间内仅允许出发一次，若在设定的时间内再次触发，则重新计算时间
  void Function()? debounce([int milliseconds = 500]) {
    if (this == null) return null;
    DateTime? lastTime;
    return () {
      if (lastTime == null || DateTime.now().difference(lastTime!).inMilliseconds > milliseconds) {
        this?.call();
      }
      lastTime = DateTime.now();
    };
  }

  /// 防抖默认时间
  static int debounceTime = 1000;

  /// 扩展Function，添加节流功能
  /// 确保在每个时间间隔内至少执行一次函数
  void Function()? throttle([int milliseconds = 500]) {
    if (this == null) return null;
    Timer? throttleTimer;
    return () {
      if (throttleTimer == null || !throttleTimer!.isActive) {
        this?.call();
        throttleTimer = Timer(Duration(milliseconds: milliseconds), () => throttleTimer?.cancel());
      }
    };
  }
}
