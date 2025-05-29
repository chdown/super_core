/// @author : ch
/// @date 2024-02-18 09:34:57
/// @description bool方法
///
extension ExtensionBool on bool? {
  /// 取value
  int get intValue {
    if (this == null) return 0;
    return this! ? 1 : 0;
  }

  /// 取反value
  int get reverseIntValue {
    if (this == null) return 1;
    return this! ? 0 : 1;
  }

  /// 取value
  String get stringValue => intValue.toString();

  /// 取value
  String get reverseStringValue => reverseIntValue.toString();

  /// true文本显示
  String trueText(String trueTxt, {String falseTxt = ''}) => this != null && this! ? trueTxt : falseTxt;

  /// false文本显示
  String falseText(String falseTxt, {String trueTxt = ''}) => this == null || !this! ? falseTxt : trueTxt;
}
