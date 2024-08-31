import 'package:demo/generated/json/base/json_convert_content.dart';

class PageRes<T> {
  late int total = 0;
  late List<T> records = [];

  PageRes();

  factory PageRes.fromJson(Map<String, dynamic> json) {
    final PageRes<T> res = PageRes<T>();
    final int? total = jsonConvert.convert<int>(json['total']);
    if (total != null) {
      res.total = total;
    }
    if (json["records"] != null) {
      final List<T>? records = JsonConvert.fromJsonAsT<List<T>>(json["records"]);
      if (records != null) {
        res.records = records;
      }
    }
    return res;
  }
}
