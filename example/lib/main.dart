import 'package:example/pages/load/loading_view.dart';
import 'package:example/route/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import 'config.dart';

void main() {
  /// 初始化生命周期 监听
  WidgetsFlutterBinding.ensureInitialized();
  Config.initNet();
  Config.initLoad();
  runApp(GetMaterialApp(
    title: 'super_core',
    getPages: AppRoutes.routerPages,
    initialRoute: AppRoutes.mainPage,
    builder: FlutterSmartDialog.init(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
      loadingBuilder: (msg) {
        return LoadingView(msg: msg);
      },
    ),
  ));
}
