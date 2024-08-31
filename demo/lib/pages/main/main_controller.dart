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

  // int mReqTime = 0;

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
        bool isTrue = true;
        List<ShopTablesEntity> list = await requestLimit<List<ShopTablesEntity>>(
          'table',
          request: () async {
            List<ShopTablesEntity> result = (await AppHttp.get<List<ShopTablesEntity>>(
                  'customer/shop/tables',
                  params: {
                    "shopId": '1770649609751498754',
                    'tableType': type, //chess
                  },
                  cancelToken: cancelToken,
                )) ??
                [];
            if (type == 'billiard') await Future.delayed(const Duration(seconds: 3));
            return result;
          },
          error: () {
            showToast('error');
            return isTrue = false;
          },
          success: (t) {
            mList = t;
            update();
            return mList;
          },
        );
      },
      loadEnum: LoadEnum.page,
    );
  }
}
