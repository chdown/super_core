import 'dart:async';
import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:super_core/src/core/load_config.dart';
import 'package:super_core/src/core/load_state.dart';
import 'package:super_core/src/http/app_net_error.dart';
import 'package:super_core/src/utils/log_util.dart';

import 'load_enum.dart';

/// @author : ch
/// @date 2024-01-13 14:25:30
/// @description Load加载基类
mixin SuperCore {
  void showLoadingState(LoadConfig loadConfig, LoadState loadState, String errorMsg);

  void showPageState(LoadConfig loadConfig, LoadState loadState, String errorMsg);

  void showRefreshState(LoadConfig loadConfig, LoadState loadState, String errorMsg);

  void showToast(String? message);

  /// 扩展异常
  String extError(Object e, String msg) => msg;

  /// 消费错误
  /// [return] 返回true时错误将不再往下进行
  Future<bool> consumptionError(Object e, StackTrace? trace) async => false;

  /// 通用的数据请求方法
  /// [request] 请求包装类，返回最终[List]数据的情况下，会自动进行空页面显示处理
  /// [loadEnum] 请求数据的方式
  /// [loadConfig] Load配置
  ///
  Future request<T>({
    required Future<dynamic> Function() request,
    LoadEnum loadEnum = LoadEnum.loading,
    LoadConfig? loadConfig,
  }) async {
    loadConfig ??= LoadConfig();
    try {
      if (await (Connectivity().checkConnectivity()) == ConnectivityResult.none) {
        throw AppNetError(code: AppNetError.errorNetUnConnection, message: AppNetError.errorNetUnConnectionMsg);
      }
      _showState(loadConfig, loadEnum, LoadState.start);
      dynamic result = await request(); // 请求数据
      bool isEmpty = result != null && result is List && result.isEmpty;
      _showState(loadConfig, loadEnum, isEmpty ? LoadState.successEmpty : LoadState.success);
    } catch (e) {
      LogUtil.e(null, error: e, stackTrace: e is Error ? (e.stackTrace) : null);
      String msg = _getErrorMsg(e);
      if (await consumptionError(e, e is Error ? (e.stackTrace) : null)) return;
      bool iseNetUnConnection = e is AppNetError && e.code == AppNetError.errorNetUnConnection;
      _showState(loadConfig, loadEnum, iseNetUnConnection ? LoadState.netError : LoadState.error, errorMsg: msg);
      rethrow;
    } finally {
      _showState(loadConfig, loadEnum, LoadState.finish);
    }
  }

  void _showState(LoadConfig loadConfig, LoadEnum loadEnum, LoadState loadState, {String errorMsg = ''}) {
    /// 输出toast
    if (errorMsg.isNotEmpty && loadConfig.isShowToast) showToast(errorMsg);

    /// 配置回调
    if (loadState == LoadState.start) loadConfig.start?.call();
    if (loadState == LoadState.success || loadState == LoadState.successEmpty) loadConfig.success?.call();
    if (loadState == LoadState.error || loadState == LoadState.netError) loadConfig.error?.call(errorMsg);
    if (loadState == LoadState.finish) loadConfig.finish?.call();

    /// load处理
    if (loadEnum == LoadEnum.loading) showLoadingState(loadConfig, loadState, errorMsg);
    if (loadEnum == LoadEnum.page) showPageState(loadConfig, loadState, errorMsg);
    if (loadEnum == LoadEnum.refresh) showRefreshState(loadConfig, loadState, errorMsg);
  }

  /// 获取错误日志
  _getErrorMsg(Object e) {
    String msg = "未知业务错误！";
    if (e is DioException) {
      if (e.error is AppNetError) {
        msg = (e.error as AppNetError).message;
      } else {
        msg = e.message ?? "未知网络错误！";
      }
    } else if (e is AppNetError) {
      msg = e.message;
    }
    msg = extError(e, msg);
    return msg;
  }
}
