import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoadingDialog() {
  Get.dialog(const LoadingDialog());
}

void dismissDialog() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}

class LoadingDialog extends Dialog {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      color: Colors.black87,
      radius: 16,
    );
  }
}
