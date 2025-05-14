
/// @author : ch
/// @date 2025-05-14 10:44:08
/// @description 防抖工具类
///
class ClickThrottlerUtils{
  static bool _locked = false;

  static bool canClick([Duration duration = const Duration(milliseconds: 500)]) {
    if (duration == Duration.zero) return true;
    if (_locked) return false;

    _locked = true;
    Future.delayed(duration, () => _locked = false);
    return true;
  }
}