import 'package:demo/pages/main/main_page.dart';
import 'package:get/get.dart';
//导包位置

abstract class AppRoutes {
  /// 首页
  static const mainPage = "/MainPage";

  static final routerPages = [
    GetPage(
      name: mainPage,
      page: () => const MainPage(),
    ),
  ];
}
