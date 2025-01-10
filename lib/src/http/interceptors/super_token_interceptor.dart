import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// token处理拦截器
class SuperTokenInterceptor extends Interceptor {
  /// 刷新token
  final VoidCallback tokenRefresh;

  /// 是否执行错误
  final bool isHandleError;

  SuperTokenInterceptor(this.tokenRefresh, this.isHandleError);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      tokenRefresh();
      if (isHandleError) handler.next(err);
    } else {
      handler.next(err);
    }
  }
}
