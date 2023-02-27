import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/config/global.dart';
import 'package:myflutterapp/config/route_configs.dart';
import 'package:myflutterapp/controller/app_controller.dart';
import 'package:myflutterapp/res/res_string.dart';
import 'dart:ui' as ui;
import 'package:myflutterapp/res/app_theme.dart';
import 'refresh/pull_to_refresh.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const WaterDropHeader(),
      footerBuilder: () => const ClassicFooter(),
      hideFooterWhenNotFull: false,
      c: GetMaterialApp(
        localizationsDelegates: const [
          RefreshLocalizations.delegate,
        ],
        theme: getThemeData(appController.theme.value),
        translations: Messages(),
        locale: ui.window.locale,
        initialRoute: RoutesConfig.splash,
        getPages: RoutesConfig.getPages,
      ),
    );
  }
}
