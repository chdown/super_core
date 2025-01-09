/// @author : ch
/// @date 2025-01-09 11:35:32
/// @description 网络连接异常
///
class AppNetError extends Error {
  static String errorNetUnConnectionMsg = "无法连接服务器，请检查您的网络环境！";

  String toString() {
    return errorNetUnConnectionMsg;
  }
}
