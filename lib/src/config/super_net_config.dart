import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';

/// @author : ch
/// @date 2024-03-06 14:20:15
/// @description 网络配置
///
class SuperNetConfig {
  SuperNetConfig();

  /// 数据请求地址
  String Function() baseUrl = () => '';

  /// 代理地址：192.160.0.1:8888
  String Function() proxyUrl = () => '';

  /// 连接等待毫秒数
  int connectTimeout = 30 * 1000;

  /// 发送等待毫秒数
  int sendTimeout = 30 * 1000;

  /// 接收等待毫秒数
  int receiveTimeout = 30 * 1000;

  /// 拦截器
  List<Interceptor> interceptors = [];

  /// dio其他扩展
  Dio Function(Dio dio) extDio = (dio) => dio;

  /// 网络code字段
  String successParam = 'code';

  /// 网络请求msg字段
  String errorMsgParam = 'msg';

  /// 请求成功code
  List<int> successData = [200];

  /// 是否跳过Response检查
  bool ignoreCheckResponse = false;

  /// 忽略错误codes，key值，在[SuperErrorInterceptor]中使用
  /// eg：Options(extra: {SuperNetConfig.ignoreErrorCodes: true})
  static const String ignoreErrorCodes = 'ignoreErrorCodes';

  /// 忽略检查，http请求时是传入key值，在[SuperErrorInterceptor]中使用时会忽略对传参的检查
  /// eg：Options(extra: {SuperNetConfig.ignoreCheck: true})
  static const String ignoreCheck = 'ignoreCheck';
}
