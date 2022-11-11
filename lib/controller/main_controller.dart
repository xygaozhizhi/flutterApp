import 'package:get/get.dart';

import '../common/constant.dart';
import '../theme/app_theme.dart';
import '../utils/sp_utils.dart';
import 'app_controller.dart';

class MainController extends GetxController {
  var title = "home".tr.obs;

  void getTitle(int index) {
    switch (index) {
      case 0:
        title.value = "home".tr;
        break;
      case 1:
        title.value = "square".tr;
        break;
      case 2:
        title.value = "public".tr;
        break;
      case 3:
        title.value = "system".tr;
        break;
      case 4:
        title.value = "project".tr;
        break;
      default:
        title.value = "home".tr;
        break;
    }
  }

  void changeTheme() {
    appController.themeModel.value =
        Get.isDarkMode ? Constant.lightThemeModel : Constant.darkThemeModel;
    Get.changeTheme(
        Get.isDarkMode ? lightTheme(appController.theme.value) : darkTheme);
    SpUtil.putString(Constant.keyThemeModel, appController.themeModel.value);
  }
}
