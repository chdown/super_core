import 'package:example/generated/json/base/json_convert_content.dart';

import 'page_res.dart';

class BasePageRes<T> {
  int? errorCode;
  String? msg;
  late PageRes<T> data = PageRes<T>();

  BasePageRes();

  factory BasePageRes.fromJson(Map<String, dynamic> json) {
    final BasePageRes<T> res = BasePageRes<T>();
    final int? errorCode = jsonConvert.convert<int>(json['errorCode']);
    if (errorCode != null) {
      res.errorCode = errorCode;
    }
    final String? errorMsg = jsonConvert.convert<String>(json['errorMsg']);
    if (errorMsg != null) {
      res.msg = errorMsg;
    }
    if (json["data"] != null) {
      res.data = PageRes<T>.fromJson(json["data"]);
    }
    return res;
  }
}
