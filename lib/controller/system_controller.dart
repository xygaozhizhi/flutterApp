import 'package:get/get.dart';
import 'package:myflutterapp/models/system_navigation.dart';
import 'package:myflutterapp/widgets/load_state.dart';
import '../common/constant.dart';
import '../http/dio_util.dart';
import '../models/system_classify.dart';

class SystemController extends GetxController {
  var classify = <SystemClassify>[].obs;
  var classifyLoadState = LoadState.loading.obs;

  var navigation = <SystemNavigation>[].obs;
  var navigationLoadState = LoadState.loading.obs;

  Future getClassify() {
    return DioUtil().requestNetwork(Method.get, Constant.systemClassify).then(
      (value) {
        classifyLoadState.value = LoadState.success;
        if (classify.isNotEmpty) {
          classify.clear();
        }
        classify.addAll(systemClassifyFromJson(value));
      },
    ).catchError(
      (e) {
        classifyLoadState.value = LoadState.failure;
      },
    );
  }

  Future getNavigation() {
    return DioUtil().requestNetwork(Method.get, Constant.systemNavigation).then(
      (value) {
        navigationLoadState.value = LoadState.success;
        if (navigation.isNotEmpty) {
          navigation.clear();
        }
        navigation.addAll(systemNavigationFromJson(value));
      },
    ).catchError(
      (e) {
        navigationLoadState.value = LoadState.failure;
      },
    );
  }
}
