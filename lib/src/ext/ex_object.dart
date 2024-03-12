import 'dart:async';

import 'package:super_core/src/utils/obj_util.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description Object方法
///
extension ObjectExtension on Object? {
  /// 是否为null或空
  bool get isEmptyOrNull => ObjUtil.isEmpty(this);

  /// 是否不为null或空
  bool get isNotEmptyOrNull => ObjUtil.isNotEmpty(this);

  /// 为空时返回Obj
  Object emptyToObj(Object obj) => isEmptyOrNull ? obj : this!;

  /// 不为空时返回Obj
  Object notEmptyToObj(Object obj) => isNotEmptyOrNull ? obj : this!;
}
