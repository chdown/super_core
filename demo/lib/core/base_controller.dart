import 'package:demo/utils/dialog_utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:super_core/super_core.dart';
import 'package:super_ui/super_ui.dart';

class BaseController extends GetxController with SuperCore {
  late RefreshController refreshController = RefreshController();
  late SuperLoadController loadPageController = SuperLoadController();

  int pageNum = 1;

  /// 下拉刷新调用的接口
  onRefresh({LoadEnum? loadEnum, LoadConfig? loadConfig}) {
    if (refreshController.isLoading) {
      refreshController.refreshToIdle();
      return;
    }
    pageNum = 1;
    request(
      request: () async {
        return await getData();
      },
      loadEnum: loadEnum ?? LoadEnum.refresh,
      loadConfig: loadConfig,
    );
  }

  /// 上拉加载调用的接口，请求失败后页面计数器-1
  onLoading() {
    if (refreshController.isRefresh) {
      refreshController.loadComplete();
      return;
    }
    request(
      request: () async {
        pageNum++;
        List? list = await getData();
        return list;
      },
      loadEnum: LoadEnum.refresh,
      loadConfig: LoadConfig(
        error: (value) {
          pageNum--;
        },
      ),
    );
  }

  /// 请求数据调用的接口，主要引用于分页查询的接口
  /// [pageNum] 为分页参数
  Future getData() async => null;

  @override
  void showToast(String? message) => DialogUtils.toast(message ?? "");

  @override
  void showLoadingState(LoadConfig loadConfig, LoadState loadState, String errorMsg) {
    if (loadState == LoadState.start) {
      DialogUtils.loading();
    } else {
      DialogUtils.dismiss();
    }
  }

  @override
  void showRefreshState(LoadConfig loadConfig, LoadState loadState, String errorMsg) {
    loadConfig.refreshController ??= refreshController;
    if (loadState != LoadState.start && loadConfig.refreshController is RefreshController) {
      RefreshController controller = loadConfig.refreshController as RefreshController;
      if (controller.isRefresh) controller.refreshCompleted();
      if (controller.isLoading) controller.loadComplete();
      if (loadState == LoadState.successEmpty) {
        loadConfig.pageController ??= loadPageController;
        SuperLoadController controller = loadConfig.pageController as SuperLoadController;
        if (loadState == LoadState.successEmpty) controller.showEmpty();
      }
    }
  }

  @override
  void showPageState(LoadConfig loadConfig, LoadState loadState, String errorMsg) {
    loadConfig.pageController ??= loadPageController;
    SuperLoadController controller = loadConfig.pageController as SuperLoadController;
    if (loadState == LoadState.start) controller.showLoading();
    if (loadState == LoadState.success) controller.showContent();
    if (loadState == LoadState.successEmpty) controller.showEmpty();
    if (loadState == LoadState.netError) controller.showNetError();
    if (loadState == LoadState.error) controller.showError();
  }

  @override
  void onClose() {
    refreshController.dispose();
    loadPageController.dispose();
    super.onClose();
  }
}
