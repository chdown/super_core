import 'package:flutter/foundation.dart';

/// @author : ch
/// @date 2024-01-23 20:19:27
/// @description 网络连接地址
///
class ApiBaseUrl {
  static String baseUrl = kReleaseMode ? 'https://app.zhui8taiqiu.com/prod-api/' : getDebugBaseUrl();

  static List<String> debugBaseUrl = [
    'http://192.168.31.200:1883/dev-api/', // 测试地址
    'https://app.zhui8taiqiu.com/prod-api/', // 线上地址
    'http://192.168.31.9:8080/', // 许
    'http://192.168.31.61:8080/', // 王
  ];

  static String getDebugBaseUrl() {
    return debugBaseUrl[0];
  }
}
