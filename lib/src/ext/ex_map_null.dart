import 'package:super_core/src/utils/obj_util.dart';

/// @author : ch
/// @date 2024-04-24 10:54:05
/// @description Map扩展类
///
extension MapExtensionNull<K, V> on Map<K, V>? {
  /// 是否为null或空
  bool get isEmptyOrNull => ObjUtil.isEmpty(this);

  /// 是否不为null或空
  bool get isNotEmptyOrNull => ObjUtil.isNotEmpty(this);
}
