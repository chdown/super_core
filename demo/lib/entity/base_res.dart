import 'package:demo/generated/json/base/json_convert_content.dart';

class BaseRes<T> {
  int? code;
  String? msg;
  T? data;

  BaseRes();

  factory BaseRes.fromJson(Map<String, dynamic> json) {
    final BaseRes<T> res = BaseRes<T>();
    final int? code = jsonConvert.convert<int>(json['code']);
    if (code != null) {
      res.code = code;
    }
    final String? msg = jsonConvert.convert<String>(json['msg']);
    if (msg != null) {
      res.msg = msg;
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
