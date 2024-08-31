import 'dart:io';

import 'package:dio/dio.dart';
import 'package:super_core/super_core.dart';
import 'package:super_ui/super_ui.dart';

import 'core/http/api_base_url.dart';
import 'generated/assets.dart';
import 'pages/load/load_custom_svg.dart';
import 'pages/load/load_loading.dart';

class Config {
  static void initNet() {
    SuperNetConfig.baseUrl = () => ApiBaseUrl.baseUrl;
    SuperNetConfig.interceptors = [
      SuperHeaderInterceptor(() async {
        return {
          'User-Agent': Platform.isAndroid ? 'Android' : 'iPhone',
          // 'Version': await DeviceUtils.getAppVersion(),
          // "Brand": await DeviceUtils.getBrand(),
          // if (ObjUtil.isNotEmpty(CacheSpUtil.getAuthorization())) 'Authorization': CacheSpUtil.getAuthorization().toString(),
        };
      }),
      QueuedInterceptor(),
      SuperLogInterceptor(),
      // SuperErrorInterceptor(() {
      //   EventBus.instance.emit(EventKeys.token);
      // }),
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
