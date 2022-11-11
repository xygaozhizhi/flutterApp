import 'dart:convert';

List<BannerData> bannerFromJson(String str) =>
    List<BannerData>.from(json.decode(str).map((x) => BannerData.fromJson(x)));

String bannerToJson(List<BannerData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerData {
  BannerData({
    this.desc = '',
    this.id = 0,
    this.imagePath = '',
    this.isVisible = 0,
    this.order = 0,
    this.title = '',
    this.type = 0,
    this.url = '',
  });

  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        desc: json["desc"],
        id: json["id"],
        imagePath: json["imagePath"],
        isVisible: json["isVisible"],
        order: json["order"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "id": id,
        "imagePath": imagePath,
        "isVisible": isVisible,
        "order": order,
        "title": title,
        "type": type,
        "url": url,
      };
}
