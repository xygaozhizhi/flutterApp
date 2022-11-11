import 'package:get/get.dart';
import 'package:myflutterapp/utils/sp_utils.dart';

import '../controller/app_controller.dart';
import '../http/dio_util.dart';

class Global {
  static Future init() async {
    await SpUtil.getInstance();
    Get.put<AppController>(AppController());
  }
}

DioUtil get client => Get.find<DioUtil>();
