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
          await Future.delayed(
            const Duration(seconds: 3),
            () async {
              mList = (await AppHttp.get<List<ShopTablesEntity>>(
                    'customer/shop/tables',
                    params: {
                      "shopId": '1770649609751498754',
                      'tableType': type, //chess
                    },
                    cancelToken: cancelToken,
                  )) ??
                  [];
              update();
              return mList;
            },
          );
        } else {
          mList = (await AppHttp.get<List<ShopTablesEntity>>(
                'customer/shop/tables',
                params: {
                  "shopId": '1770649609751498754',
                  'tableType': type, //chess
                },
                cancelToken: cancelToken,
              )) ??
              List.empty();
          update();
          return mList;
        }
      },
      loadEnum: LoadEnum.page,
    );
  }
}
