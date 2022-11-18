import 'dart:convert';

List<ArticlesTab> publicTabFromJson(String str) =>
    List<ArticlesTab>.from(json.decode(str).map((x) => ArticlesTab.fromJson(x)));

String publicTabToJson(List<ArticlesTab> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArticlesTab {
  ArticlesTab({
    this.articleList = const [],
    this.author,
    this.children = const [],
    this.courseId,
    this.cover,
    this.desc,
    this.id = 0,
    this.lisense,
    this.lisenseLink,
    this.name = "",
    this.order,
    this.parentChapterId,
    this.type,
    this.userControlSetTop,
    this.visible,
  });

  List<dynamic> articleList;
  String? author;
  List<dynamic> children;
  int? courseId;
  String? cover;
  String? desc;
  int id;
  String? lisense;
  String? lisenseLink;
  String name;
  int? order;
  int? parentChapterId;
  int? type;
  bool? userControlSetTop;
  int? visible;

  factory ArticlesTab.fromJson(Map<String, dynamic> json) => ArticlesTab(
        articleList: List<dynamic>.from(json["articleList"].map((x) => x)),
        author: json["author"],
        children: List<dynamic>.from(json["children"].map((x) => x)),
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
        "articleList": List<dynamic>.from(articleList.map((x) => x)),
        "author": author,
        "children": List<dynamic>.from(children.map((x) => x)),
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
