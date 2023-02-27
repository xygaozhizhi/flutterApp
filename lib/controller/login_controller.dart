import 'package:get/get.dart';
import 'package:myflutterapp/common/constant.dart';
import 'package:myflutterapp/controller/app_controller.dart';
import 'package:myflutterapp/http/dio_util.dart';
import 'package:myflutterapp/res/res_string.dart';
import 'package:myflutterapp/utils/sp_utils.dart';
import 'package:myflutterapp/utils/toast_utils.dart';
import 'package:myflutterapp/widgets/dialog_utils.dart';

class LoginController extends GetxController {
  Future<void> register(Map<String, String> params) async {
    showLoadingDialog();
    await DioUtil()
        .requestNetwork(Method.post, Constant.register, queryParameters: params)
        .then((value) {
      showToast(registerSuccessAndToLogin.tr);
    }).catchError((e) {
      showToast(e.msg);
    });
    dismissDialog();
  }

  Future<void> login(Map<String, String> params) async {
    showLoadingDialog();
    await DioUtil()
        .requestNetwork(Method.post, Constant.login, queryParameters: params)
        .then((value) {
      SpUtil.putBool(Constant.isLogin, true);
      appController.isLogin.value = true;
    }).catchError((e) {
      showToast(e.msg);
    });
    dismissDialog();
  }
}
