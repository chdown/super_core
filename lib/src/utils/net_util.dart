import 'package:connectivity_plus/connectivity_plus.dart';

/// @author : ch
/// @date 2024-11-14 16:12:04
/// @description 网络工具类
///
class NetUtils {
  static Future<bool> isConnect() async {
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
