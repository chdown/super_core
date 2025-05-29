import 'package:dio/dio.dart';

/// @author : ch
/// @date 2025年5月29日18:26:55
/// @description SuperConfig配置
///
class SuperConfig {
  SuperConfig._();

  /// requestTimeout请求超时时间，默认不设置
  /// 全局生效，建议设置合理的事件，避免请求正确了但是触发此异常
  static Duration? requestTimeout;

  /// 请求超时错误信息
  static String Function() errorRequestTimeout = () => "request timeout error！";
}
