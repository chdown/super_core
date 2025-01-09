import 'package:demo/generated/json/base/json_convert_content.dart';

class BaseRes<T> {
  int? errorCode;
  String? errorMsg;
  T? data;

  BaseRes();

  factory BaseRes.fromJson(Map<String, dynamic> json) {
    final BaseRes<T> res = BaseRes<T>();
    final int? errorCode = jsonConvert.convert<int>(json['errorCode']);
    if (errorCode != null) {
      res.errorCode = errorCode;
    }
    final String? errorMsg = jsonConvert.convert<String>(json['errorMsg']);
    if (errorMsg != null) {
      res.errorMsg = errorMsg;
    }
    if (json["data"] != null) {
      final T? data = JsonConvert.fromJsonAsT<T>(json["data"]);
      if (data != null) {
        res.data = data;
      }
    }
    return res;
  }
}
