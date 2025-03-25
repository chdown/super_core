/// @author : ch
/// @date 2025-03-21 10:40:17
/// @description 错误消息
///
class HttpErrorMsg {
  static String Function() errorDataMsg = () => "数据错误，请稍后再试！";

  static String Function() errorNetUnConnectionMsg = () => "无法连接服务器，请检查您的网络环境！";

  static String Function() sendTimeoutMsg = () => "请求服务器超时，请稍后再试！";

  static String Function() connectionTimeoutMsg = () => "连接服务器超时，请稍后再试！";

  static String Function() connectionErrorMsg = () => "连接服务器异常，请稍后再试！";

  static String Function() badCertificateMsg = () => "请求证书异常，请稍后再试！";

  static String Function() cancelMsg = () => "请求被异常取消，请稍后再试！";

  static String Function() receiveTimeoutMsg = () => "响应超时，请稍后再试！";

  static String Function() unknownMsg = () => "未知异常，请检查网络后再试！";

  static String Function() badResponseMsg = () => "服务器异常，请稍后重试！";

  static String Function() requestMsg = () => "网络请求异常，请稍后重试！";
}
