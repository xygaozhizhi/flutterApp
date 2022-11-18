import 'package:get/get.dart';
import '../common/constant.dart';
import '../http/dio_util.dart';
import '../models/articles.dart';
import '../widgets/load_state.dart';

class SquareController extends GetxController {
  var squareArticles = MainArticles().obs;

  List<Articles> articles = <Articles>[].obs;
  var loadState = LoadState.loading.obs;

  @override
  void onInit() {
    super.onInit();
    loadState.value = LoadState.loading;
    getData(false);
  }

  void getData(bool isLoadMore) {
    DioUtil()
        .requestNetwork(
          Method.get,
          Constant.squareArticles(0),
          onSuccess: (data) {
            if (!isLoadMore) {
              articles.clear();
            }
            squareArticles.value = mainArticlesFromJson(data);
            articles.addAll(squareArticles.value.articles);
          },
        )
        .then((value) => loadState.value = LoadState.success)
        .catchError((e) => loadState.value = LoadState.failure);
  }
}
