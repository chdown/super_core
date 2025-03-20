/// @author : ch
/// @date 2025-01-09 11:35:32
/// @description 数据错误
///
class AppError extends Error {
  final String errorMsg;

  AppError(this.errorMsg);

  String toString() {
    return errorMsg;
  }
}
