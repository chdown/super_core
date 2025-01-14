根据 `chdown/super_core` 仓库中的 `lib/super_core.dart` 文件及其引用的相关代码文件，生成以下详细的 README 使用文档：

---

# SuperCore

`SuperCore` 是一个 Dart 库，提供了一系列核心组件和扩展功能，旨在简化应用程序开发中的常见任务，如加载状态管理、错误处理、网络请求等。

## 功能

- 加载状态管理
- 错误处理
- 网络请求拦截器
- 常用工具类和扩展方法

## 安装

请确保在 `pubspec.yaml` 文件中添加了 `super_core` 依赖：

```yaml
dependencies:
  super_core:
    git:
      url: https://github.com/chdown/super_core.git
```

然后运行 `flutter pub get` 安装依赖。

## 导入

在您的 Dart 文件中导入 `super_core`：

```dart
import 'package:super_core/super_core.dart';
```

## 主要模块和使用方法

### 核心模块

#### `SuperCore`

`SuperCore` 是一个混入，提供了加载状态管理和错误处理的基本功能。

```dart
mixin SuperCore {
  void showState(LoadConfig loadConfig, LoadEnum loadEnum, LoadState loadState, String errorMsg);
  void showToast(String? message);
  Future<bool> consumptionError(Object e, StackTrace? trace) async => false;
  Future request<T>({
    required Future<dynamic> Function() request,
    LoadEnum loadEnum = LoadEnum.loading,
    LoadConfig? loadConfig,
  }) async;
}
```

| 方法                | 参数                                                                                   | 类型                                | 说明                         |
| ------------------- | -------------------------------------------------------------------------------------- | ----------------------------------- | ---------------------------- |
| `showState`         | `loadConfig` `loadEnum` `loadState` `errorMsg`                                          | `LoadConfig` `LoadEnum` `LoadState` `String` | 展示加载状态                 |
| `showToast`         | `message`                                                                              | `String?`                          | 显示 toast 消息              |
| `consumptionError`  | `e` `trace`                                                                             | `Object` `StackTrace?`              | 处理错误并防止显示 toast 或默认加载状态 |
| `request`           | `request` `loadEnum` `loadConfig`                                                      | `Future<dynamic> Function()` `LoadEnum` `LoadConfig?` | 处理数据请求并自动管理加载状态 |

### 错误处理

#### `AppDataError`

处理数据错误。

```dart
class AppDataError extends Error {
  static String errorDataMsg = "数据错误，请稍后再试！";
  String toString() {
    return errorDataMsg;
  }
}
```

#### `AppNetError`

处理网络连接错误。

```dart
class AppNetError extends Error {
  static String errorNetUnConnectionMsg = "无法连接服务器，请检查您的网络环境！";
  String toString() {
    return errorNetUnConnectionMsg;
  }
}
```

### 网络请求拦截器

#### `SuperErrorInterceptor`

处理网络请求中的错误。

```dart
class SuperErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // 处理错误逻辑
  }
}
```

#### `SuperHeaderInterceptor`

添加请求头拦截器。

```dart
class SuperHeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 添加请求头逻辑
  }
}
```

#### `SuperLogInterceptor`

日志拦截器，用于记录请求和响应日志。

```dart
class SuperLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 记录请求日志
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 记录响应日志
  }
}
```

#### `SuperTokenInterceptor`

处理请求中的 token。

```dart
class SuperTokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 处理 token 逻辑
  }
}
```

### 常用工具类和扩展方法

#### `DateUtil`

日期工具类，提供常用日期处理方法。

```dart
class DateUtil {
  static String format(DateTime date, {String format = 'yyyy-MM-dd'}) {
    // 格式化日期
  }
}
```

#### `LogUtil`

日志工具类，提供日志记录方法。

```dart
class LogUtil {
  static void d(String message) {
    // 记录调试日志
  }
  static void e(String message) {
    // 记录错误日志
  }
}
```

#### `NumUtil`

数字工具类，提供常用数字处理方法。

```dart
class NumUtil {
  static double add(double a, double b) {
    // 加法运算
  }
}
```

#### `ObjUtil`

对象工具类，提供常用对象处理方法。

```dart
class ObjUtil {
  static bool isEmpty(Object? obj) {
    // 判断对象是否为空
  }
}
```

### 扩展方法

#### `ex_bool.dart`

为 `bool` 类型添加扩展方法。

```dart
extension BoolExtension on bool {
  bool toggle() {
    return !this;
  }
}
```

#### `ex_context.dart`

为 `BuildContext` 添加扩展方法。

```dart
extension ContextExtension on BuildContext {
  void showDialog(String message) {
    // 显示对话框
  }
}
```

#### `ex_function.dart`

为 `Function` 类型添加扩展方法。

```dart
extension FunctionExtension on Function {
  void callWithDelay(Duration delay) {
    Future.delayed(delay, () => this());
  }
}
```

#### `ex_int.dart`

为 `int` 类型添加扩展方法。

```dart
extension IntExtension on int {
  int increment() {
    return this + 1;
  }
}
```

#### `ex_list.dart`

为 `List` 类型添加扩展方法。

```dart
extension ListExtension<T> on List<T> {
  void addIfNotExist(T value) {
    if (!contains(value)) add(value);
  }
}
```

#### `ex_map.dart`

为 `Map` 类型添加扩展方法。

```dart
extension MapExtension<K, V> on Map<K, V> {
  V? getOrDefault(K key, V defaultValue) {
    return this[key] ?? defaultValue;
  }
}
```

#### `ex_map_null.dart`

为 `Map` 类型添加空值处理扩展方法。

```dart
extension MapNullExtension<K, V> on Map<K, V?> {
  void removeNullValues() {
    removeWhere((key, value) => value == null);
  }
}
```

#### `ex_string.dart`

为 `String` 类型添加扩展方法。

```dart
extension StringExtension on String {
  bool isNullOrEmpty() {
    return this == null || this.isEmpty;
  }
}
```

#### `ex_t.dart`

为任意类型添加扩展方法。

```dart
extension GenericExtension<T> on T {
  void let(Function(T it) block) {
    block(this);
  }
}
```

#### `ex_padding.dart`

为 `Padding` 小部件添加扩展方法。

```dart
extension PaddingExtension on Padding {
  Padding copyWith(EdgeInsetsGeometry padding) {
    return Padding(padding: padding, child: child);
  }
}
```

#### `ex_sized_box.dart`

为 `SizedBox` 小部件添加扩展方法。

```dart
extension SizedBoxExtension on SizedBox {
  SizedBox copyWith({double? width, double? height}) {
    return SizedBox(width: width ?? this.width, height: height ?? this.height);
  }
}
```

#### `ex_align.dart`

为 `Align` 小部件添加扩展方法。

```dart
extension AlignExtension on Align {
  Align copyWith({AlignmentGeometry? alignment, double? widthFactor, double? heightFactor}) {
    return Align(alignment: alignment ?? this.alignment, widthFactor: widthFactor ?? this.widthFactor, heightFactor: heightFactor ?? this.heightFactor);
  }
}
```

#### `ex_clip.dart`

为 `Clip` 小部件添加扩展方法。

```dart
extension ClipExtension on Clip {
  Clip copyWith({Clip? clipBehavior}) {
    return Clip(clipBehavior: clipBehavior ?? this.clipBehavior);
  }
}
```

#### `ex_gesture.dart`

为 `GestureDetector` 小部件添加扩展方法。

```dart
extension GestureExtension on GestureDetector {
  GestureDetector copyWith({VoidCallback? onTap}) {
    return GestureDetector(onTap: onTap ?? this.onTap);
  }
}
```

#### `ex_padding.dart`

为 `Padding` 小部件添加扩展方法。

```dart
extension PaddingExtension on Padding {
  Padding copyWith(EdgeInsetsGeometry padding) {
    return Padding(padding: padding, child: child);
  }
}
```

#### `ex_sliver.dart`

为 `Sliver` 小部件添加扩展方法。

```dart
extension SliverExtension on Sliver {
  Sliver copyWith({Widget? sliver}) {
    return Sliver(sliver: sliver ?? this.sliver);
  }
}
```
