import 'package:get/get.dart';
import 'package:myflutterapp/routes/home/home_page.dart';
import 'package:myflutterapp/routes/main_route.dart';
import 'package:myflutterapp/routes/mine/system_setting.dart';
import 'package:myflutterapp/routes/splash_route.dart';

import '../controller/app_controller.dart';
import '../controller/home_controller.dart';
import '../controller/main_controller.dart';
import '../controller/system_setting_controller.dart';

abstract class RoutesConfig {
  static const splash = "/";
  static const main = "/main";
  static const setting = "/setting";

  static final List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => SplashRoute(),
      binding: BindingsBuilder(() {
        Get.put<AppController>(AppController());
      }),
    ),
    GetPage(
      name: main,
      page: () => MainRoute(),
      bindings: [
        BindingsBuilder(() {
          Get.put<MainController>(MainController());
          Get.put<HomeController>(HomeController());
        }),
      ],
    ),
    GetPage(
      name: setting,
      page: () => SettingRoute(),
      binding: BindingsBuilder(() {
        Get.put<SystemSettingController>(SystemSettingController());
      }),
    ),

  ];
}
