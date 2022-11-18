import 'package:get/get.dart';
import 'package:myflutterapp/controller/square_controller.dart';
import 'package:myflutterapp/controller/system_controller.dart';
import 'package:myflutterapp/routes/main_route.dart';
import 'package:myflutterapp/routes/mine/system_setting.dart';
import 'package:myflutterapp/routes/splash_route.dart';

import '../controller/app_controller.dart';
import '../controller/home_controller.dart';
import '../controller/main_controller.dart';
import '../controller/project_controller.dart';
import '../controller/public_controller.dart';
import '../controller/system_setting_controller.dart';

abstract class RoutesConfig {
  static const splash = "/";
  static const main = "/main";
  static const setting = "/setting";

  static final List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => const SplashRoute(),
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
          Get.lazyPut(()=>HomeController());
          Get.lazyPut(()=>SquareController());
          Get.lazyPut(()=>PublicController());
          Get.lazyPut(()=>SystemController());
          Get.lazyPut(()=>ProjectController());
        }),
      ],
    ),
    GetPage(
      name: setting,
      page: () => const SettingRoute(),
      binding: BindingsBuilder(() {
        Get.put<SystemSettingController>(SystemSettingController());
      }),
    ),

  ];
}
