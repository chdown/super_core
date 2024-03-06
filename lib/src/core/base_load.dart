import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:super_core/src/config/super_core_config.dart';
import 'package:super_core/src/core/load_config.dart';
import 'package:super_core/src/http/app_net_error.dart';
import 'package:super_core/src/utils/log.dart';
import 'package:super_load/super_load.dart';

/// @author : ch
/// @date 2024-01-13 14:25:30
/// @description Load加载基类
///
enum LoadEnum { none, page, loading, refresh }

mixin BaseLoad {
  late RefreshController refreshController = RefreshController(); // 刷新组件控制器
  late LoadPageController loadPageController = LoadPageController(); // 页面缺省组件控制器

  /// 通用的数据请求方法
  /// [request] 请求包装类，返回最终list数据的情况下，会自动进行空页面显示处理
  /// [loadEnum] 请求数据的方式
  /// [loadConfig] Load配置
  ///
  Future request<T>({
    required Future<List?> Function() request,
    LoadEnum loadEnum = LoadEnum.loading,
    LoadConfig? loadConfig,
  }) async {
    loadConfig ??= LoadConfig();
    loadConfig.refreshController ??= refreshController;
    loadConfig.loadPageController ??= loadPageController;
    try {
      if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
        throw AppNetError(code: AppNetError.errorNetUnConnection, message: AppNetError.errorNetUnConnectionMsg);
      }
      _showLoading(loadConfig, loadEnum);
      List? list = await request(); // 请求数据
      _showSuccess(loadConfig, loadEnum, list);
    } catch (e) {
      Log.logPrint(e);
      _showError(loadConfig, loadEnum, e);
    } finally {
      _finish(loadEnum, loadConfig);
    }
  }

  /// 显示请求中的界面
  void _showLoading(LoadConfig loadConfig, LoadEnum loadEnum) {
    loadConfig.start?.call();
    if (loadEnum == LoadEnum.loading) SuperCoreConfig.showLoading();
    if (loadEnum == LoadEnum.page) loadConfig.loadPageController?.showLoading();
  }

  /// 显示成功的界面
  void _showSuccess(LoadConfig loadConfig, LoadEnum loadEnum, List<dynamic>? list) {
    loadConfig.success?.call();
    if (loadEnum == LoadEnum.loading) SuperCoreConfig.hideLoading();
    if (loadEnum == LoadEnum.page) {
      if (list != null && list.isEmpty) {
        loadConfig.loadPageController?.showEmpty();
      } else {
        loadConfig.loadPageController?.showContent();
      }
    }
  }

  /// 限时成功的界面
  void _showError(LoadConfig loadConfig, LoadEnum loadEnum, Object e) {
    String msg = "未知业务错误！";
    if (e is DioException && e.error is AppNetError) {
      msg = (e.error as AppNetError).message;
    } else if (e is AppNetError) {
      msg = e.message;
    }
    loadConfig.error?.call(msg);
    if (loadEnum != LoadEnum.none && loadConfig.isShowErrorMsg) SuperCoreConfig.showToast(msg);
    if (e is AppNetError && e.code == AppNetError.errorNetUnConnection) {
      if (loadEnum == LoadEnum.page || loadConfig.isErrorPage) loadConfig.loadPageController?.showNetError();
    } else {
      if (loadEnum == LoadEnum.page || loadConfig.isErrorPage) loadConfig.loadPageController?.showError();
    }
  }

  void _finish(LoadEnum loadEnum, LoadConfig loadConfig) {
    if (loadEnum == LoadEnum.refresh && (loadConfig.refreshController?.isRefresh ?? false)) loadConfig.refreshController?.refreshCompleted();
    if (loadEnum == LoadEnum.refresh && (loadConfig.refreshController?.isLoading ?? false)) loadConfig.refreshController?.loadComplete();
    if (loadEnum == LoadEnum.loading) SuperCoreConfig.hideLoading();
    loadConfig.finish?.call();
  }

  void disposeCore() {
    refreshController.dispose();
    loadPageController.dispose();
  }
}
