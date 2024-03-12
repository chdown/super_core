import 'dart:async';

import 'package:super_core/src/utils/object_util.dart';

/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description Object方法
///

///
extension ObjectExtension on Object? {
  bool isNullOrEmpty() => ObjectUtil.isEmpty(this);

  bool isNotNullOrEmpty() => ObjectUtil.isNotEmpty(this);
}
