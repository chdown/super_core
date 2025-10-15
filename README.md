# Super Core

一个全面的 Flutter 工具包，提供了丰富的工具和扩展功能，用于简化 Flutter 开发。该包采用模块化设计，主要包含以下几个核心模块：

## 项目结构

```
lib/
├── src/
│   ├── config/          # 配置相关
│   │   └── super_net_config.dart
│   ├── core/            # 核心功能
│   │   ├── load_config.dart
│   │   ├── load_enum.dart
│   │   ├── load_state.dart
│   │   ├── super_core.dart
│   │   └── super_limit.dart
│   ├── ext/             # 扩展功能
│   │   ├── ex_bool.dart
│   │   ├── ex_context.dart
│   │   ├── ex_function.dart
│   │   ├── ex_int.dart
│   │   ├── ex_list.dart
│   │   ├── ex_map.dart
│   │   ├── ex_map_null.dart
│   │   ├── ex_string.dart
│   │   ├── ex_t.dart
│   │   ├── size/
│   │   └── widget/
│   ├── http/            # 网络请求
│   │   ├── error/
│   │   ├── interceptors/
│   │   └── super_http.dart
│   └── utils/           # 工具类
│       ├── date_util.dart
│       ├── log_util.dart
│       ├── num_util.dart
│       ├── obj_util.dart
│       └── plat_utils.dart
└── super_core.dart      # 主入口文件
```

## 核心模块

### 1. 配置模块 (config)
- `SuperNetConfig`: 网络配置类，用于配置网络请求的基础参数
  ```dart
  class SuperNetConfig {
    final String baseUrl;
    final int connectTimeout;
    final int receiveTimeout;
    // ...
  }
  ```

### 2. 核心功能模块 (core)
- `SuperCore`: 核心混入类，提供基础功能
  ```dart
  mixin SuperCore {
    void showState(LoadConfig loadConfig, LoadEnum loadEnum, LoadState loadState, String errorMsg);
    Future request<T>({...});
  }
  ```
- `LoadConfig`: 加载配置类
- `LoadEnum`: 加载状态枚举
- `LoadState`: 加载状态类
- `SuperLimit`: 限制控制类

### 3. 扩展模块 (ext)
- 基础类型扩展
  - `ex_bool.dart`: 布尔值扩展
  - `ex_context.dart`: 上下文扩展
  - `ex_function.dart`: 函数扩展
  - `ex_int.dart`: 整数扩展
  - `ex_list.dart`: 列表扩展
  - `ex_map.dart`: Map扩展
  - `ex_string.dart`: 字符串扩展
  - `ex_t.dart`: 泛型扩展

- Widget扩展
  - `size/`: 尺寸相关扩展
  - `widget/`: Widget相关扩展

### 4. 网络请求模块 (http)
- 错误处理
  - `AppDataError`: 数据错误
  - `AppNetError`: 网络错误
  - `AppError`: 通用错误

- 拦截器
  - `SuperErrorInterceptor`: 错误拦截器
  - `SuperHeaderInterceptor`: 请求头拦截器
  - `SuperLogInterceptor`: 日志拦截器
  - `SuperTokenInterceptor`: Token拦截器

- HTTP客户端
  - `SuperHttp`: HTTP请求工具类
  - `HttpMethod`: HTTP方法枚举
  - `HttpErrorMsg`: 错误消息处理

### 5. 工具模块 (utils)
- `DateUtil`: 日期工具类
- `LogUtil`: 日志工具类
- `NumUtil`: 数字工具类
- `ObjUtil`: 对象工具类
- `PlatUtils`: 平台工具类

## 框架管理

Super Core 是一个基于 GetX 和 Dio 的 Flutter 开发框架，主要解决以下问题：

1. **状态管理**：基于 GetX 的状态管理方案
2. **网络请求**：基于 Dio 的网络请求封装
3. **UI 组件**：常用 Widget 的扩展和封装
4. **工具类**：开发中常用的工具方法

### 框架特点

- 统一的错误处理机制
- 自动的加载状态管理
- 便捷的网络请求封装
- 丰富的扩展方法
- 完整的日志系统

### 核心控制器 (BaseController)

BaseController 是整个框架的核心组件，它继承自 GetX 的 GetxController 并混入了 SuperCore，提供了以下核心功能：

1. **状态管理**
   - 自动处理加载状态
   - 统一的错误处理
   - 便捷的数据刷新

2. **网络请求**
   - 统一的请求封装
   - 自动的错误处理
   - 便捷的响应处理

3. **生命周期管理**
   - 页面初始化
   - 数据加载
   - 资源释放

> 示例封装、引用了 ### [easy_refresh](https://pub.dev/documentation/easy_refresh/latest/) 、### [super_widget](https://github.com/chdown/super_widget)

```dart
class BaseController extends GetxController with SuperCore {
  late EasyRefreshController refreshController = EasyRefreshController(
    controlFinishLoad: true,
    controlFinishRefresh: true,
  );
  late SuperLoadController loadPageController = SuperLoadController();

  int pageNum = 1;
  int pageSize = 10;
  bool isLoopRefresh = false;

  /// 下拉刷新调用的接口
  onRefresh({LoadEnum? loadEnum, LoadConfig? loadConfig}) {
    pageNum = 1;
    request(
      request: () async {
        final result = await getData();
        // 部分场景下，PullToRefresh嵌套了刷新，所以需要展示页面
        if (result != false) loadPageController.showContent();
        if (!isLoopRefresh && result != null && result is List && result.length < pageSize) {
          refreshController.finishLoad(IndicatorResult.noMore);
        } else if (!isLoopRefresh && result != null && result is bool && !result) {
          refreshController.finishLoad(IndicatorResult.noMore);
        }
        return result;
      },
      loadEnum: loadEnum ?? LoadEnum.refresh,
      loadConfig: loadConfig,
    );
  }

  /// 上拉加载调用的接口，请求失败后页面计数器-1
  onLoading() {
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
  showToast(String? message) => DialogUtils.toast(message ?? "");

  @override
  showState(LoadConfig loadConfig, LoadEnum loadEnum, LoadState loadState, String errorMsg) async {
    if (loadEnum == LoadEnum.loading) {
      if (loadState == LoadState.start) {
        DialogUtils.loading(loadConfig.loadingText);
        Get.focusScope?.unfocus();
      } else {
        DialogUtils.dismiss();
      }
    } else if (loadEnum == LoadEnum.refresh) {
      loadConfig.refreshController ??= refreshController;
      if (loadState != LoadState.start && loadConfig.refreshController is EasyRefreshController) {
        EasyRefreshController controller = loadConfig.refreshController as EasyRefreshController;
        if (loadState == LoadState.finish) {
          if (controller.headerState?.mode == IndicatorMode.processing) controller.finishRefresh();
          if (controller.footerState?.mode == IndicatorMode.processing) controller.finishLoad();
        }
        if (loadState == LoadState.successEmpty) {
          loadConfig.pageController ??= loadPageController;
          SuperLoadController controller = loadConfig.pageController as SuperLoadController;
          if (loadState == LoadState.successEmpty) controller.showEmpty();
        }
      }
    } else if (loadEnum == LoadEnum.page) {
      loadConfig.pageController ??= loadPageController;
      SuperLoadController controller = loadConfig.pageController as SuperLoadController;
      if (loadState == LoadState.start) {
        controller.showLoading();
        Get.focusScope?.unfocus();
      }
      if (loadState == LoadState.success) controller.showContent();
      if (loadState == LoadState.successEmpty) controller.showEmpty();
      if (loadState == LoadState.netError) controller.showNetError();
      if (loadState == LoadState.error) controller.showError();
    }
  }

  void refreshLoadPage(List list) {
    if (list.isEmpty) {
      loadPageController.showEmpty();
    } else {
      loadPageController.showContent();
    }
  }

  @override
  void onClose() {
    refreshController.dispose();
    loadPageController.dispose();
    super.onClose();
  }
}

```

### 框架使用指南

#### 1. 项目初始化

```dart
void main() {
  // 初始化网络配置
  SuperNetConfig config = SuperNetConfig(
    baseUrl: 'https://api.example.com',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  
  // 初始化 GetX
  GetMaterialApp(
    title: 'Super Core Demo',
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
    defaultTransition: Transition.fade,
  );
}
```

#### 2. 控制器开发

```dart
class MainController extends BaseController {

  @override
  void onReady() {
    super.onReady();
    onRefresh(loadEnum: LoadEnum.page);
  }

  @override
  getData() async {
    // todo
    update();
  }
}
```

#### 3. 页面开发

```dart
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('main')),
          body: SuperLoad(
            controller: controller.loadPageController,
            onTap: (params) => controller.onRefresh(loadEnum: LoadEnum.page),
            child: const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
```

## 贡献指南

欢迎提交 Pull Request 或 Issue 来帮助改进这个项目。
