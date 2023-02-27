import 'package:get/get.dart';
import 'package:myflutterapp/models/user_info.dart';
import '../common/constant.dart';
import '../utils/sp_utils.dart';

class AppController extends GetxController {
  var theme = 0.obs;
  var themeModel = Constant.lightThemeModel.obs;
  var userInfo = UserInfo().obs;
  var isLogin = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    theme.value = SpUtil.getInt(Constant.keyTheme)!;
    themeModel.value = SpUtil.getString(Constant.keyThemeModel,
        defValue: Constant.lightThemeModel)!;
    isLogin.value = SpUtil.getBool(Constant.isLogin)!;
  }
}

AppController get appController => Get.find<AppController>();
