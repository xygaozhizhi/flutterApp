import 'package:get/get.dart';
import 'app_controller.dart';

class SystemSettingController extends GetxController {
  var themeIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    themeIndex.value = appController.theme.value;
  }
}
