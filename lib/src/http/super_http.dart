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
  late final CancelToken _cancelToken = CancelToken();
  late Dio _dio;

  SuperHttp._internal();

  /// 多服务管理 - 懒加载
  static final Map<String, _ServiceConfig> _serviceConfigs = {};
  static final Map<String, SuperHttp> _services = {};
  static String _defaultTag = 'default';

  /// 初始化服务
  static void init(SuperNetConfig config, {String? tag, List<Interceptor>? interceptors}) {
    final serviceTag = tag ?? _defaultTag;
    _serviceConfigs[serviceTag] = _ServiceConfig(config, interceptors);
  }

  /// 获取服务 - 懒加载
  static SuperHttp get([String? tag]) {
    final serviceTag = tag ?? _defaultTag;

    if (!_serviceConfigs.containsKey(serviceTag)) {
      throw Exception('Service "$serviceTag" not found. Please initialize it first.');
    }

    // 懒加载：如果服务不存在则创建
    if (!_services.containsKey(serviceTag)) {
      final serviceConfig = _serviceConfigs[serviceTag]!;
      final service = SuperHttp._createService(serviceConfig.config, serviceConfig.interceptors);
      _services[serviceTag] = service;
    }

    return _services[serviceTag]!;
  }

  /// 获取dio
  Dio get dio => _dio;

  /// 设置默认服务标签
  static void setDefaultTag(String tag) => _defaultTag = tag;

  /// 创建服务实例
  static SuperHttp _createService(SuperNetConfig config, List<Interceptor>? interceptors) {
    final service = SuperHttp._internal();
    service._dio = service._initDioWithConfig(config, interceptors);
    return service;
  }

  /// 使用配置初始化 Dio
  Dio _initDioWithConfig(SuperNetConfig config, List<Interceptor>? interceptors) {
    final options = BaseOptions(
      baseUrl: config.baseUrl(),
      connectTimeout: Duration(milliseconds: config.connectTimeout),
      sendTimeout: Duration(milliseconds: config.sendTimeout),
      receiveTimeout: Duration(milliseconds: config.receiveTimeout),
    );

    var dio = Dio(options);

    /// 请求代理地址，仅初始化生效
    if (config.proxyUrl().isNotEmpty) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          if (config.proxyUrl().isNotEmpty) {
            client.findProxy = (uri) => "PROXY ${config.proxyUrl()}";
          }
          client.badCertificateCallback = (_, __, ___) => true;
          return client;
        },
      );
    }

    /// 扩展dio
    dio = config.extDio(dio);

    /// 设置拦截器
    if (interceptors != null) {
      dio.interceptors.addAll(interceptors);
    }

    return dio;
  }

  /// 重置服务
  static void reset(SuperNetConfig config, {String? tag, List<Interceptor>? interceptors}) {
    final serviceTag = tag ?? _defaultTag;
    _services.remove(serviceTag);
    _serviceConfigs.remove(serviceTag);
    init(config, tag: tag, interceptors: interceptors);
  }

  /// 取消所有请求
  void cancelRequests() => _cancelToken.cancel("cancelled");

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

/// 服务配置类
class _ServiceConfig {
  final SuperNetConfig config;
  final List<Interceptor>? interceptors;

  _ServiceConfig(this.config, this.interceptors);
}
