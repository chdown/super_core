/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description bool方法
///
extension IntExtension on int? {
  /// string形式的bool值
  bool getBool() => this != null && this == 1;

  /// 取反value
  int getReverseBoolInt() => getBool() ? 0 : 1;
}
