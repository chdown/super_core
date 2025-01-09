import 'package:demo/generated/json/base/json_field.dart';
import 'package:demo/generated/json/article_entity.g.dart';
import 'dart:convert';
export 'package:demo/generated/json/article_entity.g.dart';

@JsonSerializable()
class ArticleEntity {
  late bool adminAdd = false;
  late String apkLink = '';
  late int audit = 0;
  late String author = '';
  late bool canEdit = false;
  late int chapterId = 0;
  late String chapterName = '';
  late bool collect = false;
  late int courseId = 0;
  late String desc = '';
  late String descMd = '';
  late String envelopePic = '';
  late bool fresh = false;
  late String host = '';
  late int id = 0;
  late bool isAdminAdd = false;
  late String link = '';
  late String niceDate = '';
  late String niceShareDate = '';
  late String origin = '';
  late String prefix = '';
  late String projectLink = '';
  late int publishTime = 0;
  late int realSuperChapterId = 0;
  late int selfVisible = 0;
  late int shareDate = 0;
  late String shareUser = '';
  late int superChapterId = 0;
  late String superChapterName = '';
  late List<ArticleTags> tags = [];
  late String title = '';
  late int type = 0;
  late int userId = 0;
  late int visible = 0;
  late int zan = 0;

  ArticleEntity();

  factory ArticleEntity.fromJson(Map<String, dynamic> json) => $ArticleEntityFromJson(json);

  Map<String, dynamic> toJson() => $ArticleEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ArticleTags {
  late String name = '';
  late String url = '';

  ArticleTags();

  factory ArticleTags.fromJson(Map<String, dynamic> json) => $ArticleTagsFromJson(json);

  Map<String, dynamic> toJson() => $ArticleTagsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}