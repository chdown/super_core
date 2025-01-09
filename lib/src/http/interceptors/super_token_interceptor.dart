import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// token处理拦截器
class SuperTokenInterceptor extends Interceptor {
  final VoidCallback tokenRefresh;

  SuperTokenInterceptor(this.tokenRefresh);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      tokenRefresh();
    } else {
      handler.next(err);
    }
  }
}
