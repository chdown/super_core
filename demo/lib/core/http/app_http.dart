import 'dart:io';

import 'package:demo/entity/base_page_res.dart';
import 'package:demo/entity/base_res.dart';
import 'package:demo/entity/page_res.dart';
import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';

class AppHttp {
  /// get请求
  /// [path] 请求地址
  /// [params] 请求参数
  /// [options] 请求配置
  /// [cancelToken] 取消CancelToken
  /// [ignoreNull] 是否忽略参数为空
  ///
  static Future<T?> get<T>(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool ignoreNull = false,
  }) async {
    var result = await SuperHttp.instance.get(path, params: params, options: options, cancelToken: cancelToken);
    final model = BaseRes<T>.fromJson(result.data);
    if (ignoreNull && model.data == null) throw AppDataError();
    return model.data;
  }

  /// get请求
  /// [path] 请求地址
  /// [params] 请求参数
  /// [options] 请求配置
  /// [cancelToken] 取消CancelToken
  ///
  static Future<List<T>> getList<T>(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var result = await getListBase<T>(path, params: params, options: options, cancelToken: cancelToken);
    return result.datas;
  }

  /// get请求
  /// [path] 请求地址
  /// [params] 请求参数
  /// [options] 请求配置
  /// [cancelToken] 取消CancelToken
  ///
  static Future<PageRes<T>> getListBase<T>(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var result = await SuperHttp.instance.get(path, params: params, options: options, cancelToken: cancelToken);
    final model = BasePageRes<T>.fromJson(result.data);
    return model.data;
  }

  /// post请求
  /// [path] 请求地址
  /// [params] 请求参数
  /// [queryParameters] 请求参数
  /// [jsonContentType] 请求方式
  /// [options] 请求配置
  /// [cancelToken] 取消CancelToken
  /// [ignoreNull] 是否忽略参数为空
  ///
  static Future<T?> post<T>(
    String path, {
    params,
    Map<String, dynamic>? queryParameters,
    String? jsonContentType = Headers.jsonContentType,
    Options? options,
    CancelToken? cancelToken,
    bool ignoreNull = false,
  }) async {
    var result = await SuperHttp.instance.post(
      path,
      params: params,
      queryParameters: queryParameters,
      jsonContentType: jsonContentType,
      options: options,
      cancelToken: cancelToken,
    );
    final model = BaseRes<T>.fromJson(result.data);
    if (ignoreNull && model.data == null) throw AppDataError();
    return model.data;
  }

  /// post请求
  /// [path] 请求地址
  /// [queryParameters] 请求参数
  /// [jsonContentType] 请求方式
  /// [options] 请求配置
  /// [cancelToken] 取消CancelToken
  ///
  static Future<List<T>> postList<T>(
    String path, {
    params,
    Map<String, dynamic>? queryParameters,
    String? jsonContentType = Headers.jsonContentType,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var result = await postBaseList<T>(
      path,
      params: params,
      queryParameters: queryParameters,
      jsonContentType: jsonContentType,
      options: options,
      cancelToken: cancelToken,
    );
    return result.datas;
  }

  /// post请求
  /// [path] 请求地址
  /// [params] 请求参数
  /// [queryParameters] 请求参数
  /// [jsonContentType] 请求方式
  /// [options] 请求配置
  /// [cancelToken] 取消CancelToken
  ///
  static Future<PageRes<T>> postBaseList<T>(
    String path, {
    params,
    Map<String, dynamic>? queryParameters,
    String? jsonContentType = Headers.jsonContentType,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var result = await SuperHttp.instance.post(
      path,
      params: params,
      queryParameters: queryParameters,
      jsonContentType: jsonContentType,
      options: options,
      cancelToken: cancelToken,
    );
    final model = BasePageRes<T>.fromJson(result.data);
    return model.data;
  }

  /// upload请求
  /// [path] 请求地址
  /// [params] 请求参数
  /// [queryParameters] 请求参数
  /// [file] 请求文件
  /// [jsonContentType] 请求方式
  /// [options] 请求配置
  /// [cancelToken] 取消CancelToken
  ///
  static Future<T?> upload<T>(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParameters,
    required File file,
    String? jsonContentType = Headers.multipartFormDataContentType,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var name = file.path.fileName();
    dynamic data = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: name),
      if (params.isNotEmptyOrNull) ...params!,
    });
    return await post<T>(
      path,
      params: data,
      queryParameters: queryParameters,
      jsonContentType: jsonContentType,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// post请求
  /// [path] 请求地址
  /// [savePath] 文件保存路径
  /// [params] 请求数据
  /// [queryParameters] 请求参数
  /// [jsonContentType] 请求方式
  /// [options] 请求配置
  /// [cancelToken] 取消CancelToken
  /// [ignoreNull] 是否湖绿空
  ///
  static Future<T?> download<T>(
    String path,
    String savePath, {
    params,
    Map<String, dynamic>? queryParameters,
    String? jsonContentType = Headers.jsonContentType,
    Options? options,
    CancelToken? cancelToken,
    bool ignoreNull = false,
  }) async {
    var result = await SuperHttp.instance.download(
      path,
      savePath,
      params: params,
      queryParameters: queryParameters,
      jsonContentType: jsonContentType,
      options: options,
      cancelToken: cancelToken,
    );
    if (result is Map<String, dynamic>) {
      final model = BaseRes<T>.fromJson(result);
      if (ignoreNull && model.data == null) throw AppDataError();
      return model.data;
    }
  }
}
