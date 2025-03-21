import 'package:super_core/src/http/http_error_msg.dart';

/// @author : ch
/// @date 2025-01-09 11:35:32
/// @description 网络连接异常
///
class AppNetError extends Error {

  String toString() {
    return HttpErrorMsg.errorNetUnConnectionMsg();
  }
}
