import 'dart:ui';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:super_load/super_load.dart';

/// @author : ch
/// @date 2024-03-06 11:19:51
/// @description Load配置类
///
class LoadConfig {
  RefreshController? refreshController; // 刷新组件控制器
  LoadPageController? loadPageController; // 页面缺省组件控制器
  VoidCallback? start;
  VoidCallback? success;
  Function(String msg)? error;
  VoidCallback? finish;
  bool isErrorPage;
  bool isShowErrorMsg;

  LoadConfig({
    this.refreshController,
    this.loadPageController,
    this.start,
    this.success,
    this.error,
    this.finish,
    this.isErrorPage = false,
    this.isShowErrorMsg = false,
  });
}
