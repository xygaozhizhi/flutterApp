import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/common/constant.dart';
import 'package:myflutterapp/config/global.dart';
import 'package:myflutterapp/config/route_configs.dart';
import 'package:myflutterapp/controller/app_controller.dart';
import 'package:myflutterapp/res/res_string.dart';
import 'dart:ui' as ui;
import 'package:myflutterapp/res/app_theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'http/dio_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  initDio();
  runApp(const MyApp());
}

void initDio() {
  final List<Interceptor> interceptors = <Interceptor>[];
  if (kDebugMode) {
    //interceptors.add(LogInterceptor());
  }
  configDio(
    baseUrl: Constant.baseUrl,
    interceptors: interceptors,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const WaterDropHeader(),
      footerBuilder: () => const ClassicFooter(),
      hideFooterWhenNotFull: false,
      child: GetMaterialApp(
        theme: getThemeData(appController.theme.value),
        translations: Messages(),
        locale: ui.window.locale,
        initialRoute: RoutesConfig.splash,
        getPages: RoutesConfig.getPages,
      ),
    );
  }
}
