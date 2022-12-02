import 'package:get/get.dart';
import 'package:myflutterapp/common/constant.dart';
import 'package:myflutterapp/http/dio_util.dart';
import '../models/articles.dart';
import '../models/articles_tab.dart';
import '../refresh/src/smart_refresher.dart';
import '../widgets/load_state.dart';

class PublicController extends GetxController {
  List<ArticlesTab> tabs = <ArticlesTab>[].obs;
  var tabState = LoadState.loading.obs;

  var tabLoadStates = <int, LoadState>{}.obs;
  var tabMainArticles = <int, MainArticles>{}.obs;
  var tabArticles = <int, RxList<Articles>>{}.obs;
  var tabRefreshController = <int, RefreshController>{};
  var tabPage = <int, int>{};

  void getTabs() {
    DioUtil().requestNetwork(Method.get, Constant.publicTabs).then((value) {
      if (tabs.isEmpty) {
        tabs.addAll(publicTabFromJson(value));
        for (var element in tabs) {
          tabLoadStates[element.id] = LoadState.loading;
          tabMainArticles[element.id] = MainArticles();
          tabArticles[element.id] =RxList();
          tabRefreshController[element.id] = RefreshController();
          tabPage[element.id] = 1;
        }
      }
      tabState.value = tabs.isEmpty ? LoadState.empty : LoadState.success;
    }).catchError((e) {
      tabState.value = LoadState.failure;
    });
  }

  void getTabArticles(LoadModel loadModel, int publicId) {
    DioUtil()
        .requestNetwork(
            Method.get, Constant.publicArticles(publicId, tabPage[publicId]!))
        .then((value) {
      if (loadModel != LoadModel.loadMore &&
          tabArticles[publicId]!.isNotEmpty) {
        tabArticles[publicId]!.clear();
      }
      MainArticles mainArticles = mainArticlesFromJson(value);
      tabMainArticles[publicId] = mainArticles;
      tabArticles[publicId]!.addAll(mainArticles.articles);
      if (loadModel == LoadModel.refresh) {
        tabRefreshController[publicId]!
            .refreshCompleted(resetFooterState: true);
      } else if (loadModel == LoadModel.loading) {
        tabLoadStates[publicId] = tabArticles[publicId]!.isEmpty
            ? LoadState.empty
            : LoadState.success;
      } else {
        if ((tabMainArticles[publicId]!.curPage ?? 1) <=
            (tabMainArticles[publicId]!.pageCount ?? 1)) {
          tabRefreshController[publicId]!.loadComplete();
        } else {
          tabRefreshController[publicId]!.loadNoData();
        }
      }
    }).catchError((e) {
      switch (loadModel) {
        case LoadModel.loading:
          tabLoadStates[publicId] = LoadState.failure;
          break;
        case LoadModel.refresh:
          tabRefreshController[publicId]!.refreshFailed();
          break;
        case LoadModel.loadMore:
          tabRefreshController[publicId]!.loadFailed();
          break;
      }
    });
  }
}
