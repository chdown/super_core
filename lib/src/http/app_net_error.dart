/// @author : ch
/// @date 2024-01-17 16:28:54
/// @description App异常处理
///
class AppNetError extends Error {
  static const int errorToken = 401;

  static const int errorUnKnow = -1;
  static String errorKnowMsg = "未知错误，请稍后再试！";

  static const int errorDio = -2;

  static const int errorData = -3;
  static String errorDataMsg = "数据错误，请稍后再试！";

  static const int errorNetUnConnection = -4;
  static String errorNetUnConnectionMsg = "无法连接服务器，请检查您的网络环境！";

  static String sendTimeoutMsg = "请求服务器超时，请稍后再试！";
  static String connectionTimeoutMsg = "连接服务器超时，请稍后再试！";
  static String cancelMsg = "请求被异常取消，请稍后再试！";
  static String receiveTimeoutMsg = "响应超时，请稍后再试！";
  static String connectionErrorMsg = "连接服务器异常，请稍后再试！";
  static String error400Msg = "错误的请求";
  static String error403Msg = "服务器拒绝请求";
  static String error404Msg = "未知的请求地址";
  static String error500Msg = "服务出现错误(500)";
  static String error502Msg = "服务出现错误(502)";
  static String error503Msg = "服务出现错误(503)";

  /// 错误码
  final int code;

  /// 错误信息
  final String message;

  AppNetError({required this.code, required this.message});
}
