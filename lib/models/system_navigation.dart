import 'dart:convert';
import 'package:myflutterapp/models/articles.dart';

List<SystemNavigation> systemNavigationFromJson(String str) =>
    List<SystemNavigation>.from(
        json.decode(str).map((x) => SystemNavigation.fromJson(x)));

String systemNavigationToJson(List<SystemNavigation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SystemNavigation {
  SystemNavigation({
    this.articles,
    this.cid,
    this.name,
  });

  List<Articles>? articles;
  int? cid;
  String? name;

  factory SystemNavigation.fromJson(Map<String, dynamic> json) =>
      SystemNavigation(
        articles: List<Articles>.from(
            json["articles"].map((x) => Articles.fromJson(x))),
        cid: json["cid"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
        "cid": cid,
        "name": name,
      };
}
