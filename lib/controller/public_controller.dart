import 'package:get/get.dart';
import 'package:myflutterapp/common/constant.dart';
import 'package:myflutterapp/http/dio_util.dart';
import '../models/articles.dart';
import '../models/articles_tab.dart';
import '../widgets/load_state.dart';

class PublicController extends GetxController {
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
        .requestNetwork(Method.get, Constant.publicTabs)
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

  Future getTabArticles(int publicId, int page) {
    return DioUtil()
        .requestNetwork(Method.get, Constant.publicArticles(publicId, page))
        .then((value) {
      loadState[publicId] = LoadState.success;
      MainArticles mainArticles = mainArticlesFromJson(value);
      if (allArticles[publicId] == null) {
        allArticles[publicId] = [];
      }
      allArticles[publicId]!.addAll(mainArticles.articles);
    }).catchError((e) {
      loadState[publicId] = LoadState.failure;
    });
  }
}
