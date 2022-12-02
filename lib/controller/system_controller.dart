import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/models/system_navigation.dart';
import 'package:myflutterapp/refresh/pull_to_refresh.dart';
import 'package:myflutterapp/widgets/load_state.dart';
import '../common/constant.dart';
import '../http/dio_util.dart';
import '../models/system_classify.dart';

class SystemController extends GetxController {
  var classify = <SystemClassify>[].obs;
  var classifyLoadState = LoadState.loading.obs;
  late RefreshController classifyRefreshController;

  var navigation = <SystemNavigation>[].obs;
  var navigationLoadState = LoadState.loading.obs;
  var selectIndex = 0.obs;
  var globalKeys = <GlobalKey>[];

  @override
  void onInit() {
    super.onInit();
    classifyRefreshController = RefreshController();
  }

  void getClassify(LoadModel loadModel) {
    DioUtil().requestNetwork(Method.get, Constant.systemClassify).then((value) {
      if (classify.isNotEmpty) {
        classify.clear();
      }
      classify.addAll(systemClassifyFromJson(value));
      if (loadModel == LoadModel.loading) {
        classifyLoadState.value =
            classify.isEmpty ? LoadState.empty : LoadState.success;
      } else if (loadModel == LoadModel.refresh) {
        classifyRefreshController.refreshCompleted();
      }
    }).catchError((e) {
      if (loadModel == LoadModel.loading) {
        classifyLoadState.value = LoadState.failure;
      } else if (loadModel == LoadModel.refresh) {
        classifyRefreshController.refreshFailed();
      }
    });
  }

  void getNavigation() {
    DioUtil()
        .requestNetwork(Method.get, Constant.systemNavigation)
        .then((value) {
      if (navigation.isNotEmpty) {
        navigation.clear();
      }
      navigation.addAll(systemNavigationFromJson(value));
      for (var _ in navigation) {
        globalKeys.add(GlobalKey());
      }
      navigationLoadState.value =
          navigation.isEmpty ? LoadState.empty : LoadState.success;
    }).catchError((e) {
      navigationLoadState.value = LoadState.failure;
    });
  }
}
