
/// @author : ch
/// @date 2024-03-12 11:57:28
/// @description Object工具类
///
class ObjectUtil{
  /// Returns true  String or List or Map is empty.
  static bool isEmpty(Object? object) {
    if (object == null) return true;
    if (object is String && object.isEmpty) {
      return true;
    } else if (object is Iterable && object.isEmpty) {
      return true;
    } else if (object is Map && object.isEmpty) {
      return true;
    }else if (object is List && object.isEmpty) {
      return true;
    }
    return false;
  }

  /// Returns true String or List or Map is not empty.
  static bool isNotEmpty(Object? object) {
    return !isEmpty(object);
  }
}