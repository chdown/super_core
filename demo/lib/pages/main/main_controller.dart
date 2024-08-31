import 'package:demo/core/export.dart';
import 'package:demo/entity/shop_tables_entity.dart';
import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';

/// @author ChengHao
/// @date 2024-02-04 14:06:16
/// @description 首页
///
class MainController extends BaseController {
  List<ShopTablesEntity> mList = [];
  CancelToken cancelToken = CancelToken();
  int mReqTime = 0;

  String tableType = "billiard";

  @override
  void onReady() {
    super.onReady();
    onRefresh(loadEnum: LoadEnum.page);
  }

  @override
  getData() async {
    getTableData("billiard");
  }

  getTableData(String type) async {
    request(
      request: () async {
        if (type == 'billiard') {
          int reqTime = DateTime.now().millisecondsSinceEpoch;
          mReqTime = reqTime;
          await Future.delayed(
            const Duration(seconds: 3),
            () async {
              List<ShopTablesEntity> list = (await AppHttp.get<List<ShopTablesEntity>>(
                    'customer/shop/tables',
                    params: {
                      "shopId": '1770649609751498754',
                      'tableType': type, //chess
                    },
                    cancelToken: cancelToken,
                  )) ??
                  [];
              if (reqTime != mReqTime) return mList;
              mList = list;
              update();
              return mList;
            },
          );
        } else {
          int reqTime = DateTime.now().millisecondsSinceEpoch;
          mReqTime = reqTime;
          List<ShopTablesEntity> list = (await AppHttp.get<List<ShopTablesEntity>>(
                'customer/shop/tables',
                params: {
                  "shopId": '1770649609751498754',
                  'tableType': type, //chess
                },
                cancelToken: cancelToken,
              )) ??
              List.empty();
          if (reqTime != mReqTime) return mList;
          mList = list;
          update();
          return mList;
        }
      },
      loadEnum: LoadEnum.page,
    );
  }
}
