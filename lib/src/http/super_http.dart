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
  final CancelToken _cancelToken = CancelToken();
  static SuperHttp? _instance;
  late Dio _dio;

  static SuperHttp get instance {
    return _instance ??= SuperHttp();
  }

  Dio getDio() => _dio;

  SuperHttp() {
    /// 网络配置
    final options = BaseOptions(
      baseUrl: SuperNetConfig.baseUrl(),
      connectTimeout: Duration(milliseconds: SuperNetConfig.connectTimeout),
      sendTimeout: Duration(milliseconds: SuperNetConfig.sendTimeout),
      receiveTimeout: Duration(milliseconds: SuperNetConfig.receiveTimeout),
    );

    _dio = Dio(options);

    /// 请求代理地址，仅初始化生效
    if (SuperNetConfig.proxyUrl().isNotEmpty) {
      _dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.findProxy = (uri) {
            return "PROXY ${SuperNetConfig.proxyUrl()}";
          };
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
          return client;
        },
      );
    }

    /// 扩展dio
    _dio = SuperNetConfig.extDio(_dio);

    // 设置Dio的拦截器
    for (Interceptor interceptor in SuperNetConfig.interceptors) {
      _dio.interceptors.add(interceptor);
    }
  }

  /// 取消请求
  void cancelRequests() {
    _cancelToken.cancel("cancelled");
  }

  /// 重制Dio实例方法
  static reset() {
    _instance = SuperHttp();
  }

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
