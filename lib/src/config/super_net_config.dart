import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';

/// @author : ch
/// @date 2024-03-06 14:20:15
/// @description 网络配置
///
class SuperNetConfig {

  SuperNetConfig._();

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

  /// 展示具体错误
  static bool showDetailError = true;

  /// 网络code字段
  static String successParam = 'code';

  /// 网络请求msg字段
  static String errorMsgParam = 'msg';

  /// 请求成功code
  static List<int> successData = [200];

  /// 防抖默认时间
  static int debounceTime = 500;

  /// 忽略错误codes，key值，在[SuperErrorInterceptor]中使用
  static String paramIgnoreErrorCodes = 'ignoreErrorCodes';

  /// 忽略检查，key值，在[SuperErrorInterceptor]中使用
  static String paramIgnoreCheck = 'ignoreCheck';
}
