import 'dart:async';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description 防抖节流方法
///

typedef StringCallback = void Function(String value);

typedef IntCallback = void Function(int value);

///
// 扩展Function，添加防抖功能
extension DebounceExtension on Function() {
  void Function() debounce([int milliseconds = 500]) {
    Timer? debounceTimer;
    return () {
      if (debounceTimer?.isActive ?? false) debounceTimer?.cancel();
      debounceTimer = Timer(Duration(milliseconds: milliseconds), this);
    };
  }
}

// 扩展Function，添加节流功能
extension ThrottleExtension on Function {
  void Function() throttle([int milliseconds = 500]) {
    bool isAllowed = true;
    Timer? throttleTimer;
    return () {
      if (!isAllowed) return;
      isAllowed = false;
      this();
      throttleTimer?.cancel();
      throttleTimer = Timer(Duration(milliseconds: milliseconds), () {
        isAllowed = true;
      });
    };
  }
}
