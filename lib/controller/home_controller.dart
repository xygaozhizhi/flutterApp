import 'package:get/get.dart';
import 'package:myflutterapp/common/constant.dart';
import 'package:myflutterapp/http/dio_util.dart';
import 'package:myflutterapp/models/banner.dart';
import 'package:myflutterapp/widgets/load_state.dart';
import '../models/articles.dart';
import '../refresh/src/smart_refresher.dart';

class HomeController extends GetxController {
  late RefreshController refreshController;

  List<BannerData> bannerItems = <BannerData>[].obs;
  var bannerIndex = 0.obs;
  var homeArticles = MainArticles().obs;
  List<Articles> articles = <Articles>[].obs;

  var loadState = LoadState.loading.obs;
  var loadPage = 0;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController();
  }

  void getData(LoadModel loadModel) {
    var futures = <Future>[];
    if (loadModel != LoadModel.loadMore) {
      futures.add(_getBanner());
      futures.add(_getTopArticles());
      futures.add(_getArticles());
    } else {
      futures.add(_getArticles());
    }
    Future.wait(futures).then((value) {
      if (loadModel != LoadModel.loadMore) {
        if (bannerItems.isNotEmpty) {
          bannerItems.clear();
        }
        bannerItems.addAll(bannerFromJson(value[0]));

        List<Articles> topArticles = articlesFromJson(value[1]);
        for (var article in topArticles) {
          article.isTop = true;
        }
        if (articles.isNotEmpty) {
          articles.clear();
        }
        articles.addAll(topArticles);

        homeArticles.value = mainArticlesFromJson(value[2]);
        articles.addAll(homeArticles.value.articles);

        if (loadModel == LoadModel.refresh) {
          refreshController.refreshCompleted(resetFooterState: true);
        } else {
          loadState.value = (bannerItems.isEmpty && articles.isEmpty)
              ? LoadState.empty
              : LoadState.success;
        }
      } else {
        if ((homeArticles.value.curPage ?? 0) <=
            (homeArticles.value.pageCount ?? 0)) {
          homeArticles.value = mainArticlesFromJson(value[0]);
          articles.addAll(homeArticles.value.articles);
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

  Future _getTopArticles() {
    return DioUtil().requestNetwork(
      Method.get,
      Constant.topArticles,
    );
  }

  Future _getArticles() {
    return DioUtil().requestNetwork(
      Method.get,
      Constant.homeArticles(loadPage),
    );
  }

  Future _getBanner() {
    return DioUtil().requestNetwork(
      Method.get,
      Constant.banner,
    );
  }
}
