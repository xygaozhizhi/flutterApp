import 'dart:convert';

MainArticles mainArticlesFromJson(String str) =>
    MainArticles.fromJson(json.decode(str));

String mainArticlesToJson(MainArticles data) => json.encode(data.toJson());

class MainArticles {
  MainArticles({
    this.curPage,
    this.articles = const <Articles>[],
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  });

  int? curPage;
  List<Articles> articles;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  factory MainArticles.fromJson(Map<String, dynamic> json) => MainArticles(
        curPage: json["curPage"],
        articles:
            List<Articles>.from(json["datas"].map((x) => Articles.fromJson(x))),
        offset: json["offset"],
        over: json["over"],
        pageCount: json["pageCount"],
        size: json["size"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['curPage'] = curPage;
    data['datas'] = articles.map((v) => v.toJson()).toList();
    data['offset'] = offset;
    data['over'] = over;
    data['pageCount'] = pageCount;
    data['size'] = size;
    data['total'] = total;
    return data;
  }
}

List<Articles> articlesFromJson(String str) =>
    List<Articles>.from(json.decode(str).map((x) => Articles.fromJson(x)));

String articlesToJson(List<Articles> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Articles {
  Articles({
    this.adminAdd,
    this.apkLink,
    this.audit,
    this.author = "",
    this.canEdit,
    this.chapterId,
    this.chapterName,
    this.collect,
    this.courseId,
    this.desc,
    this.descMd,
    this.envelopePic,
    this.fresh = false,
    this.host,
    this.id,
    this.isAdminAdd,
    this.link,
    this.niceDate,
    this.niceShareDate,
    this.origin,
    this.prefix,
    this.projectLink,
    this.publishTime,
    this.realSuperChapterId,
    this.selfVisible,
    this.shareDate,
    this.shareUser = "",
    this.superChapterId,
    this.superChapterName,
    this.tags = const <Tag>[],
    this.title,
    this.type,
    this.userId,
    this.visible,
    this.zan,
  });

  bool? adminAdd;
  String? apkLink;
  int? audit;
  String author;
  bool? canEdit;
  int? chapterId;
  String? chapterName;
  bool? collect;
  int? courseId;
  String? desc;
  String? descMd;
  String? envelopePic;
  bool fresh;
  String? host;
  int? id;
  bool? isAdminAdd;
  String? link;
  String? niceDate;
  String? niceShareDate;
  String? origin;
  String? prefix;
  String? projectLink;
  int? publishTime;
  int? realSuperChapterId;
  int? selfVisible;
  int? shareDate;
  String shareUser;
  int? superChapterId;
  String? superChapterName;
  List<Tag> tags;
  String? title;
  int? type;
  int? userId;
  int? visible;
  int? zan;
  bool isTop = false;

  factory Articles.fromJson(Map<String, dynamic> json) => Articles(
        adminAdd: json["adminAdd"],
        apkLink: json["apkLink"],
        audit: json["audit"],
        author: json["author"],
        canEdit: json["canEdit"],
        chapterId: json["chapterId"],
        chapterName: json["chapterName"],
        collect: json["collect"],
        courseId: json["courseId"],
        desc: json["desc"],
        descMd: json["descMd"],
        envelopePic: json["envelopePic"],
        fresh: json["fresh"],
        host: json["host"],
        id: json["id"],
        isAdminAdd: json["isAdminAdd"],
        link: json["link"],
        niceDate: json["niceDate"],
        niceShareDate: json["niceShareDate"],
        origin: json["origin"],
        prefix: json["prefix"],
        projectLink: json["projectLink"],
        publishTime: json["publishTime"],
        realSuperChapterId: json["realSuperChapterId"],
        selfVisible: json["selfVisible"],
        shareDate: json["shareDate"],
        shareUser: json["shareUser"],
        superChapterId: json["superChapterId"],
        superChapterName: json["superChapterName"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        title: json["title"],
        type: json["type"],
        userId: json["userId"],
        visible: json["visible"],
        zan: json["zan"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adminAdd'] = adminAdd;
    data['apkLink'] = apkLink;
    data['audit'] = audit;
    data['author'] = author;
    data['canEdit'] = canEdit;
    data['chapterId'] = chapterId;
    data['chapterName'] = chapterName;
    data['collect'] = collect;
    data['courseId'] = courseId;
    data['desc'] = desc;
    data['descMd'] = descMd;
    data['envelopePic'] = envelopePic;
    data['fresh'] = fresh;
    data['host'] = host;
    data['id'] = id;
    data['isAdminAdd'] = isAdminAdd;
    data['link'] = link;
    data['niceDate'] = niceDate;
    data['niceShareDate'] = niceShareDate;
    data['origin'] = origin;
    data['prefix'] = prefix;
    data['projectLink'] = projectLink;
    data['publishTime'] = publishTime;
    data['realSuperChapterId'] = realSuperChapterId;
    data['selfVisible'] = selfVisible;
    data['shareDate'] = shareDate;
    data['shareUser'] = shareUser;
    data['superChapterId'] = superChapterId;
    data['superChapterName'] = superChapterName;
    data['tags'] = tags.map((v) => v.toJson()).toList();
    data['title'] = title;
    data['type'] = type;
    data['userId'] = userId;
    data['visible'] = visible;
    data['zan'] = zan;
    return data;
  }
}

class Tag {
  Tag({
    this.name = "",
    this.url,
  });

  String name;
  String? url;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
