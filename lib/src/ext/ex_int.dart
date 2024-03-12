/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description bool方法
///
extension IntExtension on int? {
  /// 取反value
  int inversionValue() {
    if (this == null) return 1;
    return this == 0 ? 1 : 0;
  }
}
