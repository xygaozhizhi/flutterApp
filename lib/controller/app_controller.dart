import 'package:get/get.dart';

import '../common/constant.dart';
import '../utils/sp_utils.dart';

class AppController extends GetxController {
  var theme = 0.obs;
  var themeModel = Constant.lightThemeModel.obs;

  @override
  void onInit() {
    super.onInit();
    theme.value = SpUtil.getInt(Constant.keyTheme)!;
    themeModel.value = SpUtil.getString(Constant.keyThemeModel,
        defValue: Constant.lightThemeModel)!;
  }
}

AppController get appController => Get.find<AppController>();
