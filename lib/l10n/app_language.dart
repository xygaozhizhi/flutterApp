import 'package:get/get_navigation/get_navigation.dart';

const String cn = "zh_CN";
const String us = "en_US";

const String home = "home";
const String square = "square";
const String public = "public";
const String system = "system";
const String project = "project";
const String goLogin = "go_login";
const String grade = "grade";
const String ranking = "ranking";
const String myIntegral = "my_integral";
const String myCollect = "my_collect";
const String myShare = "my_share";
const String myTodo = "my_todo";
const String nightMode = "night_mode";
const String systemSettings = "system_settings";
const String settings = "settings";
const String basicSettings = "basic_settings";
const String noImageMode = "no_image_mode";
const String noImageModeDesc = "no_image_mode_desc";
const String topArticleOnTheHomepage = "top_article_on_the_homepage";
const String topArticleOnTheHomepageDesc = "top_article_on_the_homepage_desc";
const String automaticallySwitchNightMode = "automatically_switch_night_mode";
const String setTheSwitchingTime = "set_the_switching_time";
const String otherSettings = "other_settings";
const String themeColor = "theme_color";
const String customThemeColors = "custom_theme_colors";
const String clearCache = "clear_cache";
const String about = "about";
const String version = "version";
const String currentVersion = "current_version";
const String customize = "customize";
const String cancel = "cancel";
const String sure = "sure";

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        cn: {
          home: "首页",
          square: "广场",
          public: "公众号",
          system: "体系",
          project: "项目",
          goLogin: "去登录",
          grade: "等级",
          ranking: "排名",
          myIntegral: "我的积分",
          myCollect: "我的收藏",
          myShare: "我的分享",
          myTodo: "TODO",
          nightMode: "夜间模式",
          systemSettings: "系统设置",
          settings: "设置",
          basicSettings: "基本设置",
          noImageMode: "无图模式",
          noImageModeDesc: "开启后在非Wifi环境下不加载图片",
          topArticleOnTheHomepage: "是否显示首页置顶文章",
          topArticleOnTheHomepageDesc: "开启后将不会显示首页置顶文章",
          automaticallySwitchNightMode: "自动切换夜间模式",
          setTheSwitchingTime: "设置切换的时间",
          otherSettings: "其他设置",
          themeColor: "主题颜色",
          customThemeColors: "自定义主题颜色",
          clearCache: "清除缓存",
          about: "关于",
          version: "版本",
          currentVersion: "当前版本",
          customize: "自定义",
          cancel: "取消",
          sure: "确定",
        },
        us: {
          home: "Home",
          square: "Square",
          public: "Public",
          system: "System",
          project: "Project",
          goLogin: "Go login",
          grade: "Grade",
          ranking: "Ranking",
          myIntegral: "My integral",
          myCollect: "Collect",
          myShare: "Share",
          myTodo: "TODO",
          nightMode: "Night mode",
          systemSettings: "System settings",
          settings: "Settings",
          basicSettings: "Basic settings",
          noImageMode: "No image mode",
          noImageModeDesc:
              "After opening, the picture does not load in a non-Wifi environment",
          topArticleOnTheHomepage:
              "Whether to display the top article on the homepage",
          topArticleOnTheHomepageDesc:
              "After it is turned on, it will not display the top article on the homepage",
          automaticallySwitchNightMode: "Automatically switch night mode",
          setTheSwitchingTime: "Set the switching time",
          otherSettings: "Other settings",
          themeColor: "Theme color",
          customThemeColors: "Custom theme colors",
          clearCache: "Clear cache",
          about: "About",
          version: "Version",
          currentVersion: "Current version",
          customize: "Customize",
          cancel: "Cancel",
          sure: "Sure",
        },
      };
}
