import 'package:dio/dio.dart';

/// @author : ch
/// @date 2024-03-06 14:20:15
/// @description 网络配置
///
class SuperNetConfig {
  /// 数据请求地址
  static String Function() baseUrl = () => '';

  /// 代理地址：192.160.0.1:8888
  static String Function() proxyUrl = () => '';

  /// 连接等待毫秒数
  static int connectTimeout = 30 * 1000;

  /// 发送等待毫秒数
  static int sendTimeout = 30 * 1000;

  /// 接收等待毫秒数
  static int receiveTimeout = 30 * 1000;

  /// 拦截器
  static List<Interceptor> interceptors = [];

  /// dio其他扩展
  static Dio Function(Dio dio) extDio = (dio) => dio;

  /// 判断结果是否包含对应的字段，用来判断是否进行自动化异常处理
  static String match = 'code';

  /// 网络code字段
  static String code = 'code';

  /// 网络请求msg字段
  static String msg = 'msg';

  /// 请求成功code
  static List<int> codeSuccess = [200];

  /// debug输出日志
  static bool showDebugLog = true;
}
