import 'package:get/get.dart';
import 'package:myflutterapp/models/user_info.dart';
import 'package:myflutterapp/res/res_string.dart';
import 'package:myflutterapp/utils/toast_utils.dart';
import 'package:myflutterapp/widgets/dialog_utils.dart';
import '../common/constant.dart';
import '../http/dio_util.dart';
import '../res/app_theme.dart';
import '../utils/sp_utils.dart';
import 'app_controller.dart';

class MainController extends GetxController {
  var title = home.tr.obs;

  @override
  void onInit() {
    super.onInit();
    ever(appController.isLogin, (callback) {
      if (appController.isLogin.value) {
        getUserInfo();
      }
    });
  }

  void getTitle(int index) {
    switch (index) {
      case 0:
        title.value = home.tr;
        break;
      case 1:
        title.value = square.tr;
        break;
      case 2:
        title.value = public.tr;
        break;
      case 3:
        title.value = system.tr;
        break;
      case 4:
        title.value = project.tr;
        break;
      default:
        title.value = home.tr;
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

  Future<void> collectArticle(int id) async {
    showLoadingDialog();
    await DioUtil()
        .requestNetwork(Method.post, Constant.collectArticle(id))
        .catchError((e) => showToast(e.msg));
    dismissDialog();
  }

  void getUserInfo() {
    DioUtil().requestNetwork(Method.get, Constant.userInfo).then((value) {
      appController.userInfo.value = userInfoFromJson(value);
    }).catchError((e) {
      showToast(e.msg);
    });
  }

  void logout() {
    DioUtil().requestNetwork(Method.get, Constant.logout).then((value) {
      appController.userInfo.value = UserInfo();
      appController.isLogin.value=false;
    }).catchError((e) {
      showToast(e.msg);
    });
  }
}
