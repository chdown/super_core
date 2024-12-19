import 'package:connectivity_plus/connectivity_plus.dart';

/// @author : ch
/// @date 2024-11-14 16:12:04
/// @description 网络工具类
///
class NetUtils {
  static Future<bool> isConnect() async {
    List<ConnectivityResult> list = await Connectivity().checkConnectivity();
    return list.isNotEmpty && (list.length == 1 && list.first != ConnectivityResult.none);
  }

  static Future<bool> isConnectWifi() async {
    List<ConnectivityResult> list = await Connectivity().checkConnectivity();
    return list.isNotEmpty && (list.length == 1 && list.first != ConnectivityResult.none) && list.contains(ConnectivityResult.wifi);
  }
}
