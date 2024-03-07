/// @author : ch
/// @date 2024-03-07 09:10:46
/// @description 加载状态
///
enum LoadState {
  /// 开始回调
  start,

  /// 成功回调
  success,

  /// 成功回调，空页面处理
  successEmpty,

  /// 完成回调，finally中执行
  finish,

  /// 网络未连接状态
  netError,

  /// 错误状态，除[netError]
  error,
}
