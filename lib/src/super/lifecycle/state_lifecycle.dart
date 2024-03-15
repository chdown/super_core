/// @author : ch
/// @date 2024-03-14 16:44:17
/// @description 生命周期
///
// 自定义生命周期回调接口
abstract class StateLifecycle {
  void onStart(); //启动页面
  void onStop(); //结束页面
  void onResume(); //重新可见
  void onPause(); //被覆盖隐藏
}
