/// @author : ch
/// @date 2025-01-09 12:01:43
/// @description 网络工具
///
class NetUtils {
//
//   /// 6.0以上版本
//   static Future<bool> isConnect() async {
//     List<ConnectivityResult> list = await Connectivity().checkConnectivity();
//     return list.isNotEmpty && (list.length == 1 && list.first != ConnectivityResult.none);
//   }
//
//   static Future<bool> isConnectWifi() async {
//     List<ConnectivityResult> list = await Connectivity().checkConnectivity();
//     return list.isNotEmpty && (list.length == 1 && list.first != ConnectivityResult.none) && list.contains(ConnectivityResult.wifi);
//   }
//
//   /// 6.0以下版本
//   static Future<bool> isConnect() async {
//     ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
//
//   static Future<bool> isConnectWifi() async {
//     ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult == ConnectivityResult.wifi;
//   }
}
