import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/utils/sp_utils.dart';
import 'package:path_provider/path_provider.dart';
import '../common/constant.dart';
import '../controller/app_controller.dart';
import '../http/dio_util.dart';
import '../http/interceptor.dart';

class Global {
  static Future init() async {
    await SpUtil.getInstance();
    await initDio();
    Get.put<AppController>(AppController());
  }

  static Future<void> initDio() async {
    final List<Interceptor> interceptors = <Interceptor>[];
    interceptors.add(LoginInterceptors());
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var cj = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage("$appDocPath/.cookies/"));
    interceptors.add(CookieManager(cj));
    if (kDebugMode) {
      //interceptors.add(LogInterceptor());
    }
    configDio(
      baseUrl: Constant.baseUrl,
      interceptors: interceptors,
    );
  }
}
