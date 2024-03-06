import 'dart:ui';

import 'package:dio/dio.dart';

/// @author : ch
/// @date 2024-03-06 14:20:15
/// @description 网络配置
///
class SuperNetConfig {
  /// 数据请求地址
  static String baseUrl = '';

  /// 代理地址：192.160.0.1:8888
  static String proxyUrl = '';

  /// 连接等待毫秒数
  static int connectTimeout = 30 * 1000;

  /// 发送等待毫秒数
  static int sendTimeout = 30 * 1000;

  /// 接收等待毫秒数
  static int receiveTimeout = 30 * 1000;

  /// 拦截器
  static List<Interceptor> interceptors = [];

  /// dio其他扩展
  static Dio extDio(Dio dio) => dio;

  /// 网络code字段
  static String code = 'code';

  /// 网络请求msg字段
  static String msg = 'msg';

  static VoidCallback tokenRefresh = (){};
}
