/// @author : ch
/// @date 2025-01-09 11:35:32
/// @description 数据错误
///
class AppDataError extends Error {
  static String errorDataMsg = "数据错误，请稍后再试！";

  String toString() {
    return errorDataMsg;
  }
}
