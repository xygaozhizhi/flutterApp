import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void showLoadingDialog(){
  Get.dialog(const CupertinoAlertDialog());
}
void dismissDialog(){
  Get.back();
}
class LoadingDialog extends Dialog {
  const LoadingDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator();
  }
  static void show() {
    Get.dialog(LoadingDialog());
  }
}
