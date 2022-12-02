class Constant {
  ///主题相关常量
  static const String keyTheme = "key_theme";
  static const String keyThemeModel = "key_theme_model";
  static const String lightThemeModel = "light_theme_model";
  static const String darkThemeModel = "dark_theme_model";

  ///http基础数据结构字段常量
  static const String data = "data";
  static const String message = "errorMsg";
  static const String code = "errorCode";

  ///httpApi常量
  static const String baseUrl = "https://www.wanandroid.com/";
  static const String banner = "banner/json";
  static const String topArticles = "article/top/json";
  static const String publicTabs = "wxarticle/chapters/json";
  static const String systemClassify = "tree/json";
  static const String systemNavigation = "navi/json";
  static const String projectTabs = "project/tree/json";

  static String homeArticles(int page) {
    return "article/list/$page/json";
  }

  static String squareArticles(int page) {
    return "user_article/list/$page/json";
  }

  static String publicArticles(int publicId, int page) {
    return "wxarticle/list/$publicId/$page/json";
  }

  static String projectArticles(int cid, int page) {
    return "project/list/$page/json?cid=$cid";
  }

  static String scoreRanking(int page) {
    return "coin/rank/$page/json";
  }

  ///图片数据常量
  static const String icLauncher = "images/ic_launcher.png";
  static const String icDefaultAvatar = "images/ic_default_avatar.png";
  static const String noData = "images/img_no_data.png";
  static const String noNetwork = "images/img_no_network.png";
}
