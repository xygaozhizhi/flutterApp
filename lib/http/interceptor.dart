import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:myflutterapp/common/constant.dart';
import 'package:myflutterapp/config/route_configs.dart';
import 'package:myflutterapp/http/error_handle.dart';
import 'package:myflutterapp/utils/toast_utils.dart';
import 'package:myflutterapp/widgets/dialog_utils.dart';

class LoginInterceptors extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var obj = jsonDecode(response.data);
    int code = obj[Constant.code];
    String msg = obj[Constant.message];
    if (code == ExceptionHandle.needLoginError) {
      dismissDialog();
      showToast(msg);
      Get.toNamed(RoutesConfig.login);
      return;
    }
    return super.onResponse(response, handler);
  }
}
