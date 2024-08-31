import 'dart:convert';

import 'package:demo/generated/json/app_version_entity.g.dart';
import 'package:demo/generated/json/base/json_field.dart';

@JsonSerializable()
class AppVersionEntity {
  late String appDownPath = '';
  late String appType = '';
  late String createBy = '';
  late String createTime = '';
  late String createType = '';
  late String isForce = '';
  late String remark = '';
  late String updateBy = '';
  late String updateTime = '';
  late String updateType = '';
  late String versionDes = '';
  late int versionId = 0;
  late String versionNo = '';
  late String versionType = '';

  AppVersionEntity();

  factory AppVersionEntity.fromJson(Map<String, dynamic> json) => $AppVersionEntityFromJson(json);

  Map<String, dynamic> toJson() => $AppVersionEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
