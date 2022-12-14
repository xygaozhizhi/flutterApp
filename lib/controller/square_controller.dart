import 'package:get/get.dart';
import '../common/constant.dart';
import '../http/dio_util.dart';
import '../models/articles.dart';
import '../refresh/src/smart_refresher.dart';
import '../widgets/load_state.dart';

class SquareController extends GetxController {
  late RefreshController refreshController;

  var squareArticles = MainArticles().obs;

  List<Articles> articles = <Articles>[].obs;
  var loadState = LoadState.loading.obs;
  var loadPage = 0;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController();
  }

  void getData(LoadModel loadModel) {
    DioUtil()
        .requestNetwork(Method.get, Constant.squareArticles(loadPage))
        .then((value) {
      if (loadModel != LoadModel.loadMore && articles.isNotEmpty) {
        articles.clear();
      }
      squareArticles.value = mainArticlesFromJson(value);
      articles.addAll(squareArticles.value.articles);
      if (loadModel == LoadModel.refresh) {
        refreshController.refreshCompleted(resetFooterState: true);
      } else if (loadModel == LoadModel.loading) {
        loadState.value =
            articles.isEmpty ? LoadState.empty : LoadState.success;
      } else {
        if ((squareArticles.value.curPage ?? 0) <=
            (squareArticles.value.pageCount ?? 0)) {
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      }
    }).catchError((e) {
      switch (loadModel) {
        case LoadModel.loading:
          loadState.value = LoadState.failure;
          break;
        case LoadModel.refresh:
          refreshController.refreshFailed();
          break;
        case LoadModel.loadMore:
          refreshController.loadFailed();
          break;
      }
    });
  }
}
