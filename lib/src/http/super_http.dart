import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:super_core/src/config/super_net_config.dart';
import 'package:super_core/src/http/http_method.dart';

/// @author : ch
/// @date 2024-03-06 14:19:08
/// @description  网络请求引擎封装，目前使用的是 Dio 框架
///
///

class SuperHttp {
  static final SuperHttp _instance = SuperHttp._internal();
  final CancelToken _cancelToken = CancelToken();
  late Dio _dio;

  factory SuperHttp() => _instance;

  static SuperHttp get instance => _instance;

  SuperHttp._internal() {
    _dio = _initDio();
  }

  Dio _initDio() {
    final options = BaseOptions(
      baseUrl: SuperNetConfig.baseUrl(),
      connectTimeout: Duration(milliseconds: SuperNetConfig.connectTimeout),
      sendTimeout: Duration(milliseconds: SuperNetConfig.sendTimeout),
      receiveTimeout: Duration(milliseconds: SuperNetConfig.receiveTimeout),
    );

    var dio = Dio(options);

    /// 请求代理地址，仅初始化生效
    if (SuperNetConfig.proxyUrl().isNotEmpty) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          if (SuperNetConfig.proxyUrl().isNotEmpty) {
            client.findProxy = (uri) => "PROXY ${SuperNetConfig.proxyUrl()}";
          }
          client.badCertificateCallback = (_, __, ___) => true;
          return client;
        },
      );
    }

    /// 扩展dio
    dio = SuperNetConfig.extDio(dio);

    /// 设置Dio的拦截器
    /// 内置拦截器：[SuperHeaderInterceptor] [SuperErrorInterceptor] [SuperTokenInterceptor] [SuperLogInterceptor]
    /// dio刷新参考[https://github.com/cfug/dio/blob/main/example_dart/lib/queued_interceptor_crsftoken.dart]
    dio.interceptors.addAll(SuperNetConfig.interceptors);

    return dio;
  }

  Dio get dio => _dio;

  /// 取消所有请求
  void cancelRequests() => _cancelToken.cancel("cancelled");

  /// 重置 Dio 实例
  static void reset() => _instance._dio = _instance._initDio();

  /// req 请求方法
  ///
  /// [path] 请求地址
  /// [params] 请求数据，注意
  /// [queryParameters] 请求参数
  /// [jsonContentType] 请求参数格式
  /// [options] 配置
  /// [cancelToken] 取消
  ///
  Future<dynamic> http(
    String path, {
    required HttpMethod httpMethod,
    params,
    Map<String, dynamic>? queryParameters,
    String? jsonContentType = Headers.jsonContentType,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options customOptions = options ?? Options();
    if (httpMethod != HttpMethod.get) {
      customOptions.contentType = jsonContentType;
    }
    switch (httpMethod) {
      case HttpMethod.get:
        return await _dio.get(path, queryParameters: queryParameters ?? params, options: customOptions, cancelToken: cancelToken ?? _cancelToken);
      case HttpMethod.post:
        return await _dio.post(path, data: params, queryParameters: queryParameters, options: customOptions, cancelToken: cancelToken ?? _cancelToken);
      case HttpMethod.put:
        return await _dio.put(path, data: params, queryParameters: queryParameters, options: customOptions, cancelToken: cancelToken ?? _cancelToken);
      case HttpMethod.delete:
        return await _dio.delete(path, data: params, queryParameters: queryParameters, options: customOptions, cancelToken: cancelToken ?? _cancelToken);
      case HttpMethod.head:
        return await _dio.head(path, data: params, queryParameters: queryParameters, options: customOptions, cancelToken: cancelToken ?? _cancelToken);
    }
  }

  /// download 下载
  ///
  /// [path] 请求地址
  /// [savePath] 保存地址
  /// [params] 请求数据
  /// [queryParameters] 请求参数
  /// [jsonContentType] 请求参数格式
  /// [options] 配置
  /// [receive] 进度回调
  /// [cancelToken] 取消
  ///
  Future<dynamic> download(
    String path,
    String savePath, {
    params,
    Map<String, dynamic>? queryParameters,
    String? jsonContentType = Headers.jsonContentType,
    Options? options,
    ProgressCallback? receive,
    CancelToken? cancelToken,
  }) async {
    Options customOptions = options ?? Options();
    customOptions.contentType = jsonContentType;
    return await _dio.download(
      path,
      savePath,
      data: params,
      queryParameters: queryParameters,
      options: customOptions,
      onReceiveProgress: receive,
      cancelToken: cancelToken ?? _cancelToken,
    );
  }
}
