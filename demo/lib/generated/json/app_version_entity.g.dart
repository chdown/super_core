import 'package:demo/entity/app_version_entity.dart';
import 'package:demo/generated/json/base/json_convert_content.dart';

AppVersionEntity $AppVersionEntityFromJson(Map<String, dynamic> json) {
  final AppVersionEntity appVersionEntity = AppVersionEntity();
  final String? appDownPath = jsonConvert.convert<String>(json['appDownPath']);
  if (appDownPath != null) {
    appVersionEntity.appDownPath = appDownPath;
  }
  final String? appType = jsonConvert.convert<String>(json['appType']);
  if (appType != null) {
    appVersionEntity.appType = appType;
  }
  final String? createBy = jsonConvert.convert<String>(json['createBy']);
  if (createBy != null) {
    appVersionEntity.createBy = createBy;
  }
  final String? createTime = jsonConvert.convert<String>(json['createTime']);
  if (createTime != null) {
    appVersionEntity.createTime = createTime;
  }
  final String? createType = jsonConvert.convert<String>(json['createType']);
  if (createType != null) {
    appVersionEntity.createType = createType;
  }
  final String? isForce = jsonConvert.convert<String>(json['isForce']);
  if (isForce != null) {
    appVersionEntity.isForce = isForce;
  }
  final String? remark = jsonConvert.convert<String>(json['remark']);
  if (remark != null) {
    appVersionEntity.remark = remark;
  }
  final String? updateBy = jsonConvert.convert<String>(json['updateBy']);
  if (updateBy != null) {
    appVersionEntity.updateBy = updateBy;
  }
  final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
  if (updateTime != null) {
    appVersionEntity.updateTime = updateTime;
  }
  final String? updateType = jsonConvert.convert<String>(json['updateType']);
  if (updateType != null) {
    appVersionEntity.updateType = updateType;
  }
  final String? versionDes = jsonConvert.convert<String>(json['versionDes']);
  if (versionDes != null) {
    appVersionEntity.versionDes = versionDes;
  }
  final int? versionId = jsonConvert.convert<int>(json['versionId']);
  if (versionId != null) {
    appVersionEntity.versionId = versionId;
  }
  final String? versionNo = jsonConvert.convert<String>(json['versionNo']);
  if (versionNo != null) {
    appVersionEntity.versionNo = versionNo;
  }
  final String? versionType = jsonConvert.convert<String>(json['versionType']);
  if (versionType != null) {
    appVersionEntity.versionType = versionType;
  }
  return appVersionEntity;
}

Map<String, dynamic> $AppVersionEntityToJson(AppVersionEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['appDownPath'] = entity.appDownPath;
  data['appType'] = entity.appType;
  data['createBy'] = entity.createBy;
  data['createTime'] = entity.createTime;
  data['createType'] = entity.createType;
  data['isForce'] = entity.isForce;
  data['remark'] = entity.remark;
  data['updateBy'] = entity.updateBy;
  data['updateTime'] = entity.updateTime;
  data['updateType'] = entity.updateType;
  data['versionDes'] = entity.versionDes;
  data['versionId'] = entity.versionId;
  data['versionNo'] = entity.versionNo;
  data['versionType'] = entity.versionType;
  return data;
}

extension AppVersionEntityExtension on AppVersionEntity {
  AppVersionEntity copyWith({
    String? appDownPath,
    String? appType,
    String? createBy,
    String? createTime,
    String? createType,
    String? isForce,
    String? remark,
    String? updateBy,
    String? updateTime,
    String? updateType,
    String? versionDes,
    int? versionId,
    String? versionNo,
    String? versionType,
  }) {
    return AppVersionEntity()
      ..appDownPath = appDownPath ?? this.appDownPath
      ..appType = appType ?? this.appType
      ..createBy = createBy ?? this.createBy
      ..createTime = createTime ?? this.createTime
      ..createType = createType ?? this.createType
      ..isForce = isForce ?? this.isForce
      ..remark = remark ?? this.remark
      ..updateBy = updateBy ?? this.updateBy
      ..updateTime = updateTime ?? this.updateTime
      ..updateType = updateType ?? this.updateType
      ..versionDes = versionDes ?? this.versionDes
      ..versionId = versionId ?? this.versionId
      ..versionNo = versionNo ?? this.versionNo
      ..versionType = versionType ?? this.versionType;
  }
}
