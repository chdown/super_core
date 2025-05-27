Map<String, int> limitTagMap = {};

/// 节流数据请求
/// [tag] 区分不同的节流类型，用于创建节流与请求时间对应Map
/// [request] 具体的数据请求
/// [error] 节流生效时调用
/// [success] 正常请求完成时调用，也可以通过返回参数触发
/// [return] 正常返回使用的参数
///
Future<T> requestLimit<T>(
  String tag, {
  required Future<T> Function() request,
  Function()? error,
  Function(T result)? success,
}) async {
  int tmpTime = DateTime.now().millisecondsSinceEpoch;
  limitTagMap[tag] = tmpTime;
  try {
    dynamic result = await request();
    if (tmpTime != limitTagMap[tag]) {
      error?.call();
    } else {
      success?.call(result);
    }
    return result;
  } catch (e) {
    error?.call();
    rethrow;
  }
}
