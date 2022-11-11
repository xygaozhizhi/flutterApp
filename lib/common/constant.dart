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

  static String articles(int page) {
    return "article/list/$page/json";
  }

  ///图片数据常量
  static const String icLauncher = "images/ic_launcher.png";
  static const String icDefaultAvatar = "images/ic_default_avatar.png";
}
