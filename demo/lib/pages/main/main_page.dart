import 'package:demo/core/export.dart';
import 'package:demo/pages/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_core/super_core.dart';
import 'package:super_ui/super_ui.dart';

/// @description 首页
///
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text('首页首页首页首页'.lastStr())),
          body: SuperBody(
            topBody: Row(
              children: [
                SuperButton(
                  width: 80,
                  margin: const EdgeInsets.all(10),
                  type: ButtonType.filled,
                  text: 'Test',
                  onTap: () async {
                    LogUtil.i("1111");
                    AppHttp.get("http://ip-api.com/json?lang=zh-CN");
                  },
                ),
                SuperButton(
                  width: 80,
                  margin: const EdgeInsets.all(10),
                  type: controller.tableType == 'billiard' ? ButtonType.filled : ButtonType.outlined,
                  text: 'billiard',
                  onTap: () {
                    controller.tableType = "billiard";
                    controller.getTableData("billiard");
                  },
                ),
                SuperButton(
                  width: 80,
                  margin: const EdgeInsets.all(10),
                  type: controller.tableType == 'chess' ? ButtonType.filled : ButtonType.outlined,
                  text: 'chess',
                  onTap: () {
                    controller.tableType = "chess";
                    controller.getTableData("chess");
                  },
                )
              ],
            ),
            body: SuperLoad(
              controller: controller.loadPageController,
              onTap: (params) => controller.onRefresh(loadEnum: LoadEnum.page),
              child: ListView.builder(
                itemCount: controller.mList.length,
                itemBuilder: (context, index) {
                  return SuperCard(
                    child: SuperText(
                      text: controller.mList[index].tablecsName,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
