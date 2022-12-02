import 'dart:convert';

ScoreRankings scoreRankingsFromJson(String str) =>
    ScoreRankings.fromJson(json.decode(str));

String scoreRankingsToJson(ScoreRankings data) => json.encode(data.toJson());

class ScoreRankings {
  ScoreRankings({
    this.curPage,
    this.datas = const [],
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  });

  int? curPage;
  List<Score> datas;
  int? offset;
  bool? over;
  int? pageCount;
  int? size;
  int? total;

  factory ScoreRankings.fromJson(Map<String, dynamic> json) => ScoreRankings(
        curPage: json["curPage"],
        datas: List<Score>.from(json["datas"].map((x) => Score.fromJson(x))),
        offset: json["offset"],
        over: json["over"],
        pageCount: json["pageCount"],
        size: json["size"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "curPage": curPage,
        "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
        "offset": offset,
        "over": over,
        "pageCount": pageCount,
        "size": size,
        "total": total,
      };
}

class Score {
  Score({
    this.coinCount,
    this.level,
    this.nickname,
    this.rank,
    this.userId,
    this.username,
  });

  int? coinCount;
  int? level;
  String? nickname;
  String? rank;
  int? userId;
  String? username;

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        coinCount: json["coinCount"],
        level: json["level"],
        nickname: json["nickname"],
        rank: json["rank"],
        userId: json["userId"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "coinCount": coinCount,
        "level": level,
        "nickname": nickname,
        "rank": rank,
        "userId": userId,
        "username": username,
      };
}
