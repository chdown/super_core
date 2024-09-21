import 'package:super_core/src/utils/obj_util.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description Iterable方法
///
extension ListExt<T> on List<T>? {
  /// 是否为null或空
  bool get isEmptyOrNull => ObjUtil.isEmpty(this);

  /// 是否不为null或空
  bool get isNotEmptyOrNull => ObjUtil.isNotEmpty(this);

  /// 查找元素是否存在
  bool findWhere(bool Function(T element) test) {
    if (this == null) return false;
    for (var element in this!) {
      if (test(element)) return true;
    }
    return false;
  }

  /// 查找元素
  T? findWhereOrNull(bool Function(T element) test) {
    if (this == null) return null;
    for (var element in this!) {
      if (test(element)) return element;
    }
    return null;
  }

  /// 返回空数组
  List<T> empty() {
    return <T>[];
  }
}
