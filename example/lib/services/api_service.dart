import 'package:super_core/super_core.dart';

/// WanAndroid API 服务
class ApiService {
  /// 初始化
  static void init() {
    final config = SuperNetConfig();
    config.baseUrl = () => 'https://www.wanandroid.com';
    config.connectTimeout = 10000;
    config.receiveTimeout = 10000;

    SuperHttp.init(config, interceptors: [SuperLogInterceptor()]);
  }

  /// 获取 HTTP 实例
  static SuperHttp get http => SuperHttp.get();

  /// 获取首页文章列表
  /// [page] 页码，从 0 开始
  static Future<Map<String, dynamic>> getArticleList(int page) async {
    final response = await http.http('/article/list/$page/json', httpMethod: HttpMethod.get);
    return response.data;
  }

  /// 获取首页 banner
  static Future<List<dynamic>> getBanner() async {
    final response = await http.http('/banner/json', httpMethod: HttpMethod.get);
    return response.data['data'];
  }

  /// 搜索文章
  /// [page] 页码，从 0 开始
  /// [keyword] 搜索关键词
  static Future<Map<String, dynamic>> searchArticle(int page, String keyword) async {
    final response = await http.http('/article/query/$page/json', httpMethod: HttpMethod.post, params: {'k': keyword});
    return response.data;
  }

  /// 获取项目分类
  static Future<List<dynamic>> getProjectTree() async {
    final response = await http.http('/project/tree/json', httpMethod: HttpMethod.get);
    return response.data['data'];
  }

  /// 获取项目列表
  /// [page] 页码，从 1 开始
  /// [cid] 分类 ID
  static Future<Map<String, dynamic>> getProjectList(int page, int cid) async {
    final response = await http.http('/project/list/$page/json', httpMethod: HttpMethod.get, queryParameters: {'cid': cid});
    return response.data;
  }

  /// 获取热搜关键词
  static Future<List<dynamic>> getHotKeys() async {
    final response = await http.http('/hotkey/json', httpMethod: HttpMethod.get);
    return response.data['data'];
  }
}
