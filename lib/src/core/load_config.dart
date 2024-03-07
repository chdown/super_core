import 'dart:ui';

import 'package:super_core/super_core.dart';

/// @author : ch
/// @date 2024-03-06 11:19:51
/// @description Load配置类
///
class LoadConfig {
  Object? pageController;// page刷新Controller
  Object? refreshController;// refresh刷新Controller
  VoidCallback? start; // 开始回调
  VoidCallback? success; // 成功回调
  StringCallback? error; // 错误回调
  VoidCallback? finish; // 完成回调
  bool isErrorPage; // 非[LoadEnum.page]、[LoadEnum.none]是否展示错误page
  bool isShowToast; // 是否展示错误toast
  Object? config; // 扩展参数
  Object? config1; // 扩展参数

  LoadConfig({
    this.pageController,
    this.refreshController,
    this.start,
    this.success,
    this.error,
    this.finish,
    this.isErrorPage = false,
    this.isShowToast = true,
    this.config,
    this.config1,
  });
}
