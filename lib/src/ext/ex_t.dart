/// @author : ch
/// @date 2024-07-05
/// @description T方法
///
///

/// Signature of callbacks that accept a single argument and return no data.
typedef StringCallback = void Function(String);

extension LetRunApply<T> on T {
  /// let 函数与之前的示例相同，它接受一个闭包并返回其结果。
  R let<R>(R Function(T) block) {
    return block(this);
  }

  /// run 函数也与之前的示例相同，它接受一个闭包但不返回任何内容。
  void run(void Function(T) block) {
    block(this);
  }

  /// apply 函数它接受一个闭包并在当前对象上执行该闭包。然后，它返回当前对象本身
  T apply(void Function(T) block) {
    block(this);
    return this;
  }
}
