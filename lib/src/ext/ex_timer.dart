import 'dart:async';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description bool方法
///
extension TimerExtension on Timer {
  // 立即执行一次，timer可能为空
  Future<Timer> periodicRun(Duration duration, void callback(Timer? timer)) async {
    callback(null);
    return Timer.periodic(duration, callback);
  }
}
