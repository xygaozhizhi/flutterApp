import 'package:get/get.dart';
import '../common/constant.dart';
import '../http/dio_util.dart';
import '../models/articles.dart';
import '../models/articles_tab.dart';
import '../widgets/load_state.dart';

class ProjectController extends GetxController {
  List<ArticlesTab> tabs = <ArticlesTab>[].obs;
  var tabState = LoadState.loading.obs;

  var loadState = <int, LoadState>{}.obs;
  var allArticles = <int, List<Articles>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getTabs();
  }

  Future getTabs() {
    return DioUtil()
        .requestNetwork(Method.get, Constant.projectTabs)
        .then((value) {
      tabState.value = LoadState.success;
      if (tabs.isEmpty) {
        tabs.addAll(publicTabFromJson(value));
        for (var element in tabs) {
          loadState[element.id] = LoadState.empty;
        }
      }
    }).catchError((e) {
      tabState.value = LoadState.failure;
    });
  }

  Future getTabArticles(int cid, int page) {
    return DioUtil()
        .requestNetwork(Method.get, Constant.projectArticles(cid, page))
        .then((value) {
      loadState[cid] = LoadState.success;
      MainArticles mainArticles = mainArticlesFromJson(value);
      if (allArticles[cid] == null) {
        allArticles[cid] = [];
      }
      allArticles[cid]!.addAll(mainArticles.articles);
    }).catchError((e) {
      loadState[cid] = LoadState.failure;
    });
  }
}
