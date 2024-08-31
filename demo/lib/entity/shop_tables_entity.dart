import 'dart:convert';

import 'package:demo/generated/json/base/json_field.dart';
import 'package:demo/generated/json/shop_tables_entity.g.dart';

@JsonSerializable()
class ShopTablesEntity {
  late String tablecsId = '';
  late String tablecsName = '';
  late List<ShopTablesInfos> infos;

  ShopTablesEntity();

  factory ShopTablesEntity.fromJson(Map<String, dynamic> json) => $ShopTablesEntityFromJson(json);

  Map<String, dynamic> toJson() => $ShopTablesEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ShopTablesInfos {
  late String tableId = '';
  late String tableName = '';
  late String status = '';
  late String fastFreeTime = '';
  late bool fastFree = false;
  late int seconds = 0;

  ShopTablesInfos();

  factory ShopTablesInfos.fromJson(Map<String, dynamic> json) => $ShopTablesInfosFromJson(json);

  Map<String, dynamic> toJson() => $ShopTablesInfosToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
