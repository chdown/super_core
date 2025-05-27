import 'dart:convert';
import 'dart:io';

import 'package:example/entity/base_page_res.dart';
import 'package:example/entity/base_res.dart';
import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';

class AppHttp {
  static Future<T?> get<T>(
      String path, {
        params,
        Map<String, dynamic>? queryParameters,
        String? jsonContentType = Headers.jsonContentType,
        Options? options,
        CancelToken? cancelToken,
        Function(BaseRes<T> res)? finish,
      }) async {
    return await http(path,
        httpMethod: HttpMethod.get,
        params: params,
        queryParameters: queryParameters,
        jsonContentType: jsonContentType,
        options: options,
        cancelToken: cancelToken,
        finish: finish);
  }

  static Future<List<T>> getList<T>(
      String path, {
        params,
        Map<String, dynamic>? queryParameters,
        String? jsonContentType = Headers.jsonContentType,
        Options? options,
        CancelToken? cancelToken,
        Function(BasePageRes<T> res)? finish,
      }) async {
    return await httpPage(path,
        httpMethod: HttpMethod.get,
        params: params,
        queryParameters: queryParameters,
        jsonContentType: jsonContentType,
        options: options,
        cancelToken: cancelToken,
        finish: finish);
  }

  static Future<T?> post<T>(
      String path, {
        params,
        Map<String, dynamic>? queryParameters,
        String? jsonContentType = Headers.jsonContentType,
        Options? options,
        CancelToken? cancelToken,
        Function(BaseRes<T> res)? finish,
      }) async {
    return await http(path,
        httpMethod: HttpMethod.post,
        params: params,
        queryParameters: queryParameters,
        jsonContentType: jsonContentType,
        options: options,
        cancelToken: cancelToken,
        finish: finish);
  }

  static Future<List<T>> postList<T>(
      String path, {
        params,
        Map<String, dynamic>? queryParameters,
        String? jsonContentType = Headers.jsonContentType,
        Options? options,
        CancelToken? cancelToken,
        Function(BasePageRes<T> res)? finish,
      }) async {
    return await httpPage(path,
        httpMethod: HttpMethod.post,
        params: params,
        queryParameters: queryParameters,
        jsonContentType: jsonContentType,
        options: options,
        cancelToken: cancelToken,
        finish: finish);
  }

  static Future<T?> put<T>(
      String path, {
        params,
        Map<String, dynamic>? queryParameters,
        String? jsonContentType = Headers.jsonContentType,
        Options? options,
        CancelToken? cancelToken,
        Function(BaseRes<T> res)? finish,
      }) async {
    return await http(path,
        httpMethod: HttpMethod.put,
        params: params,
        queryParameters: queryParameters,
        jsonContentType: jsonContentType,
        options: options,
        cancelToken: cancelToken,
        finish: finish);
  }

  static Future<T?> delete<T>(
      String path, {
        params,
        Map<String, dynamic>? queryParameters,
        String? jsonContentType = Headers.jsonContentType,
        Options? options,
        CancelToken? cancelToken,
        Function(BaseRes<T> res)? finish,
      }) async {
    return await http(path,
        httpMethod: HttpMethod.delete,
        params: params,
        queryParameters: queryParameters,
        jsonContentType: jsonContentType,
        options: options,
        cancelToken: cancelToken,
        finish: finish);
  }

  static Future<T?> http<T>(
      String path, {
        required HttpMethod httpMethod,
        params,
        Map<String, dynamic>? queryParameters,
        String? jsonContentType = Headers.jsonContentType,
        Options? options,
        CancelToken? cancelToken,
        Function(BaseRes<T> res)? finish,
      }) async {
    var result = await SuperHttp.instance.http(
      path,
      httpMethod: httpMethod,
      params: params,
      queryParameters: queryParameters,
      jsonContentType: jsonContentType,
      options: options,
      cancelToken: cancelToken,
    );
    var js;
    if (result.data is String) {
      js = jsonDecode(result.data);
    } else {
      js = result.data;
    }

    final model = BaseRes<T>.fromJson(js);
    finish?.call(model);
    return model.data;
  }

  static Future<List<T>> httpPage<T>(
      String path, {
        required HttpMethod httpMethod,
        params,
        Map<String, dynamic>? queryParameters,
        String? jsonContentType = Headers.jsonContentType,
        Options? options,
        CancelToken? cancelToken,
        Function(BasePageRes<T> res)? finish,
      }) async {
    var result = await SuperHttp.instance.http(
      path,
      httpMethod: httpMethod,
      params: params,
      queryParameters: queryParameters,
      jsonContentType: jsonContentType,
      options: options,
      cancelToken: cancelToken,
    );
    var js;
    if (result.data is String) {
      js = jsonDecode(result.data);
    } else {
      js = result.data;
    }
    final model = BasePageRes<T>.fromJson(js);
    finish?.call(model);
    return model.data.datas;
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
    return await http<T>(
      path,
      httpMethod: HttpMethod.post,
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
        String? jsonContentType,
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

  static Future<dynamic> getData(
      String path, {
        required HttpMethod httpMethod,
        params,
        Map<String, dynamic>? queryParameters,
        String? jsonContentType = Headers.jsonContentType,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    var result = await SuperHttp.instance.http(
      path,
      httpMethod: httpMethod,
      params: params,
      queryParameters: queryParameters,
      jsonContentType: jsonContentType,
      options: options ?? Options(extra: {'ignoreCheck': true}),
      cancelToken: cancelToken,
    );
    var js;
    if (result.data is String) {
      js = jsonDecode(result.data);
    } else {
      js = result.data;
    }
    return js;
  }
}
