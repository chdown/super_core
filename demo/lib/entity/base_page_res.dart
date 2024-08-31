import 'package:demo/generated/json/base/json_convert_content.dart';

import 'page_res.dart';

class BasePageRes<T> {
  int? code;
  String? msg;
  late PageRes<T> data = PageRes<T>();

  BasePageRes();

  factory BasePageRes.fromJson(Map<String, dynamic> json) {
    final BasePageRes<T> res = BasePageRes<T>();
    final int? code = jsonConvert.convert<int>(json['code']);
    if (code != null) {
      res.code = code;
    }
    final String? msg = jsonConvert.convert<String>(json['msg']);
    if (msg != null) {
      res.msg = msg;
    }
    if (json["data"] != null) {
      res.data = PageRes<T>.fromJson(json["data"]);
    }
    return res;
  }
}
