import 'dart:async';
import 'package:dio/dio.dart';

/// @author : ch
/// @date 2025-10-15
/// @description 重试拦截器
///
/// 功能：网络异常时自动重试请求
/// 特性：简单重试、可配置重试条件
class SuperRetryInterceptor extends Interceptor {
  /// 最大重试次数
  final int maxRetryCount;

  /// 重试间隔（毫秒）
  final int retryDelay;

  /// 重试条件判断函数
  final bool Function(DioException error)? retryIf;

  SuperRetryInterceptor({
    this.maxRetryCount = 3,
    this.retryDelay = 1000,
    this.retryIf,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = err.requestOptions.extra['_retry_count'] ?? 0;

    // 检查是否应该重试
    if (retryCount < maxRetryCount && _shouldRetry(err)) {
      // 延迟后重试
      await Future.delayed(Duration(milliseconds: retryDelay));

      // 更新重试次数
      err.requestOptions.extra['_retry_count'] = retryCount + 1;

      try {
        // 重试请求
        final response = await Dio().fetch(err.requestOptions);
        handler.resolve(response);
      } catch (e) {
        // 重试失败，继续错误处理链
        if (e is DioException) {
          super.onError(e, handler);
        } else {
          super.onError(err, handler);
        }
      }
    } else {
      // 不重试或重试次数已达上限
      super.onError(err, handler);
    }
  }

  /// 判断是否应该重试
  bool _shouldRetry(DioException error) {
    // 使用自定义重试条件
    if (retryIf != null) {
      return retryIf!(error);
    }
    return true;
  }
}
