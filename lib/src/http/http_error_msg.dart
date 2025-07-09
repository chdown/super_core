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
   
  // HTTP状态码错误消息
  static String Function() unauthorizedMsg = () => "未授权，请重新登录！";
   
  static String Function() forbiddenMsg = () => "无访问权限，请联系管理员！";
   
  static String Function() notFoundMsg = () => "请求资源不存在，请稍后重试！";
   
  static String Function() serverErrorMsg = () => "服务器内部错误，请稍后重试！";
   
  static String Function() badGatewayMsg = () => "网关错误，请稍后重试！";
   
  static String Function() serviceUnavailableMsg = () => "服务暂不可用，请稍后重试！";
   
  static String Function() gatewayTimeoutMsg = () => "网关超时，请稍后重试！";
  
  // 区域限制错误消息
  static String Function() regionBlockedMsg = () => "该内容在您所在的地区不可用！";
}
