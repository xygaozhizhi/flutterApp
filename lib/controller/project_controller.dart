import 'package:get/get.dart';
import '../common/constant.dart';
import '../http/dio_util.dart';
import '../models/articles.dart';
import '../models/articles_tab.dart';
import '../refresh/src/smart_refresher.dart';
import '../widgets/load_state.dart';

class ProjectController extends GetxController {
  List<ArticlesTab> tabs = <ArticlesTab>[].obs;
  var tabState = LoadState.loading.obs;

  var loadState = <int, LoadState>{}.obs;
  var tabRefreshController = <int, RefreshController>{}.obs;
  var tabMainArticles = <int, MainArticles>{}.obs;
  var allArticles = <int, RxList<Articles>>{}.obs;
  var tabPage = <int, int>{};

  Future getTabs() {
    return DioUtil()
        .requestNetwork(Method.get, Constant.projectTabs)
        .then((value) {
      if (tabs.isEmpty) {
        tabs.addAll(publicTabFromJson(value));
        for (var element in tabs) {
          loadState[element.id] = LoadState.loading;
          tabMainArticles[element.id] = MainArticles();
          allArticles[element.id] =RxList();
          tabRefreshController[element.id] = RefreshController();
          tabPage[element.id] = 1;
        }
      }
      tabState.value = tabs.isEmpty ? LoadState.empty : LoadState.success;
    }).catchError((e) {
      tabState.value = LoadState.failure;
    });
  }

  Future getTabArticles(LoadModel loadModel,int cid) {
    return DioUtil()
        .requestNetwork(Method.get, Constant.projectArticles(cid, tabPage[cid]!))
        .then((value) {
      if (loadModel != LoadModel.loadMore &&
          allArticles[cid]!.isNotEmpty) {
        allArticles[cid]!.clear();
      }
      MainArticles mainArticles = mainArticlesFromJson(value);
      tabMainArticles[cid] = mainArticles;
      allArticles[cid]!.addAll(mainArticles.articles);
      if (loadModel == LoadModel.refresh) {
        tabRefreshController[cid]!
            .refreshCompleted(resetFooterState: true);
      } else if (loadModel == LoadModel.loading) {
        loadState[cid] = allArticles[cid]!.isEmpty
            ? LoadState.empty
            : LoadState.success;
      } else {
        if ((tabMainArticles[cid]!.curPage ?? 1) <=
            (tabMainArticles[cid]!.pageCount ?? 1)) {
          tabRefreshController[cid]!.loadComplete();
        } else {
          tabRefreshController[cid]!.loadNoData();
        }
      }
    }).catchError((e) {
      switch (loadModel) {
        case LoadModel.loading:
          loadState[cid] = LoadState.failure;
          break;
        case LoadModel.refresh:
          tabRefreshController[cid]!.refreshFailed();
          break;
        case LoadModel.loadMore:
          tabRefreshController[cid]!.loadFailed();
          break;
      }
    });
  }
}
