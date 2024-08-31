import 'package:demo/entity/shop_tables_entity.dart';
import 'package:demo/generated/json/base/json_convert_content.dart';

ShopTablesEntity $ShopTablesEntityFromJson(Map<String, dynamic> json) {
  final ShopTablesEntity shopTablesEntity = ShopTablesEntity();
  final String? tablecsId = jsonConvert.convert<String>(json['tablecsId']);
  if (tablecsId != null) {
    shopTablesEntity.tablecsId = tablecsId;
  }
  final String? tablecsName = jsonConvert.convert<String>(json['tablecsName']);
  if (tablecsName != null) {
    shopTablesEntity.tablecsName = tablecsName;
  }
  final List<ShopTablesInfos>? infos = (json['infos'] as List<dynamic>?)?.map((e) => jsonConvert.convert<ShopTablesInfos>(e) as ShopTablesInfos).toList();
  if (infos != null) {
    shopTablesEntity.infos = infos;
  }
  return shopTablesEntity;
}

Map<String, dynamic> $ShopTablesEntityToJson(ShopTablesEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tablecsId'] = entity.tablecsId;
  data['tablecsName'] = entity.tablecsName;
  data['infos'] = entity.infos.map((v) => v.toJson()).toList();
  return data;
}

extension ShopTablesEntityExtension on ShopTablesEntity {
  ShopTablesEntity copyWith({
    String? tablecsId,
    String? tablecsName,
    List<ShopTablesInfos>? infos,
  }) {
    return ShopTablesEntity()
      ..tablecsId = tablecsId ?? this.tablecsId
      ..tablecsName = tablecsName ?? this.tablecsName
      ..infos = infos ?? this.infos;
  }
}

ShopTablesInfos $ShopTablesInfosFromJson(Map<String, dynamic> json) {
  final ShopTablesInfos shopTablesInfos = ShopTablesInfos();
  final String? tableId = jsonConvert.convert<String>(json['tableId']);
  if (tableId != null) {
    shopTablesInfos.tableId = tableId;
  }
  final String? tableName = jsonConvert.convert<String>(json['tableName']);
  if (tableName != null) {
    shopTablesInfos.tableName = tableName;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    shopTablesInfos.status = status;
  }
  final String? fastFreeTime = jsonConvert.convert<String>(json['fastFreeTime']);
  if (fastFreeTime != null) {
    shopTablesInfos.fastFreeTime = fastFreeTime;
  }
  final bool? fastFree = jsonConvert.convert<bool>(json['fastFree']);
  if (fastFree != null) {
    shopTablesInfos.fastFree = fastFree;
  }
  final int? seconds = jsonConvert.convert<int>(json['seconds']);
  if (seconds != null) {
    shopTablesInfos.seconds = seconds;
  }
  return shopTablesInfos;
}

Map<String, dynamic> $ShopTablesInfosToJson(ShopTablesInfos entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['tableId'] = entity.tableId;
  data['tableName'] = entity.tableName;
  data['status'] = entity.status;
  data['fastFreeTime'] = entity.fastFreeTime;
  data['fastFree'] = entity.fastFree;
  data['seconds'] = entity.seconds;
  return data;
}

extension ShopTablesInfosExtension on ShopTablesInfos {
  ShopTablesInfos copyWith({
    String? tableId,
    String? tableName,
    String? status,
    String? fastFreeTime,
    bool? fastFree,
    int? seconds,
  }) {
    return ShopTablesInfos()
      ..tableId = tableId ?? this.tableId
      ..tableName = tableName ?? this.tableName
      ..status = status ?? this.status
      ..fastFreeTime = fastFreeTime ?? this.fastFreeTime
      ..fastFree = fastFree ?? this.fastFree
      ..seconds = seconds ?? this.seconds;
  }
}
