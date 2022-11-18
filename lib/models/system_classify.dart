import 'dart:convert';

import 'articles.dart';

List<SystemClassify> systemClassifyFromJson(String str) =>
    List<SystemClassify>.from(
        json.decode(str).map((x) => SystemClassify.fromJson(x)));

String systemClassifyToJson(List<SystemClassify> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SystemClassify {
  SystemClassify({
    this.articleList,
    this.author,
    this.children,
    this.courseId,
    this.cover,
    this.desc,
    this.id,
    this.lisense,
    this.lisenseLink,
    this.name,
    this.order,
    this.parentChapterId,
    this.type,
    this.userControlSetTop,
    this.visible,
  });

  List<Articles>? articleList;
  String? author;
  List<SystemClassify>? children;
  int? courseId;
  String? cover;
  String? desc;
  int? id;
  String? lisense;
  String? lisenseLink;
  String? name;
  int? order;
  int? parentChapterId;
  int? type;
  bool? userControlSetTop;
  int? visible;

  factory SystemClassify.fromJson(Map<String, dynamic> json) => SystemClassify(
        articleList: List<Articles>.from(
            json["articleList"].map((x) => Articles.fromJson(x))),
        author: json["author"],
        children: List<SystemClassify>.from(
            json["children"].map((x) => SystemClassify.fromJson(x))),
        courseId: json["courseId"],
        cover: json["cover"],
        desc: json["desc"],
        id: json["id"],
        lisense: json["lisense"],
        lisenseLink: json["lisenseLink"],
        name: json["name"],
        order: json["order"],
        parentChapterId: json["parentChapterId"],
        type: json["type"],
        userControlSetTop: json["userControlSetTop"],
        visible: json["visible"],
      );

  Map<String, dynamic> toJson() => {
        "articleList":
            List<dynamic>.from((articleList ?? []).map((x) => x.toJson())),
        "author": author,
        "children": List<dynamic>.from((children ?? []).map((x) => x.toJson())),
        "courseId": courseId,
        "cover": cover,
        "desc": desc,
        "id": id,
        "lisense": lisense,
        "lisenseLink": lisenseLink,
        "name": name,
        "order": order,
        "parentChapterId": parentChapterId,
        "type": type,
        "userControlSetTop": userControlSetTop,
        "visible": visible,
      };
}
