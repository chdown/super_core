import 'dart:async';

import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';

/// @author : ch
/// @date 2024-01-13 14:25:30
/// @description Load加载基类
mixin SuperCore {
  /// 展示load缺省处理
  /// [loadEnum] 加载类型
  /// [loadState] 加载状态
  void showState(LoadConfig loadConfig, LoadEnum loadEnum, LoadState loadState, String errorMsg);

  /// 输出toast
  void showToast(String? message);

  /// 消费错误：捕获异常后不展示toast、load缺省处理
  /// [return] 返回true时错误将不再往下进行
  Future<bool> consumptionError(Object e, StackTrace? trace) async => false;

  /// 通用的数据请求方法
  /// [request] 请求包装类，
  /// [loadEnum] 请求数据的方式
  /// [loadConfig] Load加载配置
  /// return 返回最终[List]数据的情况下，会自动进行空页面显示处理
  Future request<T>({
    required Future<dynamic> Function() request,
    LoadEnum loadEnum = LoadEnum.loading,
    LoadConfig? loadConfig,
  }) async {
    loadConfig ??= LoadConfig();
    try {
      await requestAfter();
      _showState(loadConfig, loadEnum, LoadState.start);
      dynamic result = await request(); // 请求数据
      bool isEmpty = result != null && result is List && result.isEmpty;
      _showState(loadConfig, loadEnum, isEmpty ? LoadState.successEmpty : LoadState.success);
    } catch (error, stackTrace) {
      LogUtil.e(error.toString(), error: error, stackTrace: stackTrace);
      if (await consumptionError(error, stackTrace)) return;
      String msg = getErrorMsg(error);
      _showState(loadConfig, loadEnum, error is AppNetError ? LoadState.netError : LoadState.error, errorMsg: msg);
    } finally {
      _showState(loadConfig, loadEnum, LoadState.finish);
    }
  }

  /// 展示状态
  /// [loadConfig] Load加载配置
  /// [loadEnum] 加载类型
  /// [loadState] 加载状态
  /// [errorMsg] 错误信息，error时展示
  void _showState(LoadConfig loadConfig, LoadEnum loadEnum, LoadState loadState, {String errorMsg = ''}) {
    /// 输出toast
    if (errorMsg.isNotEmpty && loadConfig.isShowToast) showToast(errorMsg);

    /// 配置回调
    if (loadState == LoadState.start) loadConfig.start?.call();
    if (loadState == LoadState.success || loadState == LoadState.successEmpty) loadConfig.success?.call();
    if (loadState == LoadState.error || loadState == LoadState.netError) loadConfig.error?.call(errorMsg);
    if (loadState == LoadState.finish) loadConfig.finish?.call();

    /// load处理
    showState(loadConfig, loadEnum, loadState, errorMsg);
  }

  /// 请求前置处理，可以用来进行：
  /// 1、网络检查：if (!(await NetUtils.isConnect())) throw AppNetError(code: AppNetError.errorNetUnConnection, message: AppNetError.errorNetUnConnectionMsg);
  Future<void> requestAfter() async {}

  /// 获取错误信息，字类可自用实现进行单独的日志处理
  String getErrorMsg(Object error) {
    String msg = "";
    if (error is DioException) {
      msg = error.message ?? HttpErrorMsg.requestMsg();
    } else if (error is AppNetError || error is AppDataError || error is AppError) {
      msg = error.toString();
    } else {
      msg = error.toString();
    }
    return msg;
  }
}
