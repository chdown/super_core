import 'package:demo/generated/json/base/json_convert_content.dart';

class PageRes<T> {
  late int curPage = 0;
  late int offset = 0;
  late int size = 0;
  late List<T> datas = [];

  PageRes();

  factory PageRes.fromJson(Map<String, dynamic> json) {
    final PageRes<T> res = PageRes<T>();
    final int? curPage = jsonConvert.convert<int>(json['curPage']);
    if (curPage != null) {
      res.curPage = curPage;
    }
    final int? offset = jsonConvert.convert<int>(json['offset']);
    if (offset != null) {
      res.offset = offset;
    }
    final int? size = jsonConvert.convert<int>(json['size']);
    if (size != null) {
      res.size = size;
    }
    if (json["datas"] != null) {
      final List<T>? datas = JsonConvert.fromJsonAsT<List<T>>(json["datas"]);
      if (datas != null) {
        res.datas = datas;
      }
    }
    return res;
  }
}
