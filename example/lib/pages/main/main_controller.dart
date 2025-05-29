import 'package:example/core/export.dart';
import 'package:example/entity/article_entity.dart';
import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';

/// @author ChengHao
/// @date 2024-02-04 14:06:16
/// @description 首页
///
class MainController extends BaseController {
  List<ArticleEntity> mList = [];
  CancelToken cancelToken = CancelToken();

  // int mReqTime = 0;

  String tableType = "billiard";

  @override
  void onReady() {
    super.onReady();
    onRefresh(loadEnum: LoadEnum.page);
  }

  @override
  getData() async {
    cancelToken = CancelToken();
    await Future.delayed(Duration(seconds: 3));
    mList = (await AppHttp.getList<ArticleEntity>(
      ApiUrl.articleList,
      cancelToken: cancelToken,
    ));
    update();
    return mList;
  }

  requestData() {
    onRefresh(loadEnum: LoadEnum.page);
  }

  cancel() {
    request(
      request: () async {
        await Future.delayed(Duration(seconds: 20));
      },
      timeout: Duration(seconds: 10),
    );
    // cancelToken.cancel();
    // onRefresh(loadEnum: LoadEnum.page);
  }
}
