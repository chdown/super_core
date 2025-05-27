import 'package:example/utils/dialog_utils.dart';
import 'package:super_core/super_core.dart';
import 'package:super_ui/super_ui.dart';

import 'core/http/api_base_url.dart';
import 'generated/assets.dart';
import 'pages/load/load_custom_svg.dart';
import 'pages/load/load_loading.dart';

class Config {
  static void initNet() {
    SuperNetConfig.successParam = "errorCode";
    SuperNetConfig.successData = [0];
    SuperNetConfig.errorMsgParam = "errorMsg";
    SuperNetConfig.baseUrl = () => ApiBaseUrl.baseUrl;
    SuperNetConfig.interceptors = [
      SuperHeaderInterceptor((options) async {
        return Future.value({});
      }),
      SuperErrorInterceptor(),
      SuperTokenInterceptor(() {
        DialogUtils.toast("tokemn");
      }, true),
      SuperLogInterceptor(),
    ];
  }

  static void initLoad() {
    SuperLoad.defaultPages = () {
      return {
        SuperLoadStatus.empty.name: LoadCustomSvg(Assets.svgBgLoadEmpty, "暂无相关内容"),
        SuperLoadStatus.netError.name: LoadCustomSvg(Assets.svgBgLoadNet, "哎呀，网络出错了"),
        SuperLoadStatus.error.name: LoadCustomSvg(Assets.svgBgLoadError, "加载失败"),
        SuperLoadStatus.loading.name: LoadLoading(),
      };
    };
  }
}
