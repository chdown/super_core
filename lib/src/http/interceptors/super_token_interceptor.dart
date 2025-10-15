import 'dart:async';

import 'package:dio/dio.dart';

/// @author : ch
/// @date 2025-10-15
/// @description Token刷新拦截器
///
/// 功能：自动处理401错误，刷新token并重试请求
/// 特性：防止重复刷新、防止死循环
/// 参考：https://github.com/cfug/dio/blob/main/example_dart/lib/queued_interceptor_crsftoken.dart
class SuperTokenInterceptor extends QueuedInterceptorsWrapper {
  /// 用于标记请求是否已经重试过的key
  /// 防止：请求 → 401 → 刷新 → 重试 → 401 → 死循环
  static const String _retryKey = '_token_retry_flag';

  /// 保存正在进行的token刷新Future
  /// 用于多个401请求共享同一个刷新过程
  Future<Response>? _refreshFuture;

  /// Token刷新并重试请求的回调函数
  ///
  /// 参数：[RequestOptions] requestOptions - 原始请求配置
  /// 返回：[Future<Response>] - 重试后的响应
  ///
  /// 失败处理：
  /// - 如果刷新token失败，应该抛出异常（如DioException）
  /// - 如果重试请求失败，也应该抛出异常
  /// - 拦截器会捕获异常并拒绝原始请求，不会进入死循环
  ///
  /// 使用示例：
  /// ```dart
  /// onRefreshAndRetry: (requestOptions) async {
  ///   try {
  ///     // 1. 刷新token
  ///     final newToken = await refreshTokenApi();
  ///     if (newToken == null) {
  ///       throw DioException(
  ///         requestOptions: requestOptions,
  ///         error: 'Token refresh failed',
  ///       );
  ///     }
  ///
  ///     // 2. 保存新token
  ///     await saveToken(newToken);
  ///
  ///     // 3. 更新请求头
  ///     requestOptions.headers['Authorization'] = 'Bearer $newToken';
  ///
  ///     // 4. 重试原请求
  ///     return await dio.fetch(requestOptions);
  ///   } catch (e) {
  ///     // 任何步骤失败都抛出异常，拦截器会处理
  ///     throw DioException(
  ///       requestOptions: requestOptions,
  ///       error: 'Refresh and retry failed: $e',
  ///     );
  ///   }
  /// }
  /// ```
  final Future<Response> Function(RequestOptions requestOptions)? onRefreshAndRetry;

  SuperTokenInterceptor({this.onRefreshAndRetry});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 只处理401错误
    if (err.response?.statusCode == 401 && onRefreshAndRetry != null) {
      // 检查是否已经重试过，防止死循环
      final hasRetried = err.requestOptions.extra[_retryKey] == true;

      if (hasRetried) {
        // 已重试过但仍401，直接拒绝
        handler.reject(err);
        return;
      }

      // 如果没有正在进行的刷新，开始新的刷新
      if (_refreshFuture == null) {
        // 标记请求已重试过
        err.requestOptions.extra[_retryKey] = true;

        _refreshFuture = onRefreshAndRetry!(err.requestOptions).whenComplete(() {
          // 延迟清空，让队列中的请求能访问到已完成的Future
          Future.delayed(Duration.zero, () {
            _refreshFuture = null;
          });
        });
      }

      try {
        // 等待刷新完成（后续请求会复用同一个Future）
        final response = await _refreshFuture!;
        handler.resolve(response);
      } catch (e) {
        // 刷新失败
        if (e is DioException) {
          handler.reject(e);
        } else {
          handler.reject(err);
        }
      }
    } else {
      super.onError(err, handler);
    }
  }
}
