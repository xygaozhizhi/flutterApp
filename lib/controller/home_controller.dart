import 'package:get/get.dart';
import 'package:myflutterapp/common/constant.dart';
import 'package:myflutterapp/http/dio_util.dart';
import 'package:myflutterapp/models/banner.dart';
import 'package:myflutterapp/widgets/load_state.dart';
import '../models/articles.dart';

class HomeController extends GetxController {
  List<BannerData> bannerItems = <BannerData>[].obs;
  var homeArticles = MainArticles().obs;
  List<Articles> articles = <Articles>[].obs;
  var loadState = LoadState.loading.obs;

  var bannerTitle = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadState.value = LoadState.loading;
    getData(false);
  }

  void getData(bool isLoadMore) {
    var futures = <Future>[];
    if (!isLoadMore) {
      futures.add(_getBanner());
      futures.add(_getTopArticles());
      futures.add(_getArticles());
    } else {
      futures.add(_getArticles());
    }
    Future.wait(futures)
        .then((value) => loadState.value = LoadState.success)
        .catchError((e) => loadState.value = LoadState.failure);
  }

  Future _getTopArticles() {
    return DioUtil().requestNetwork(
      Method.get,
      Constant.topArticles,
      onSuccess: (data) {
        List<Articles> topArticles = articlesFromJson(data);
        for (var article in topArticles) {
          article.isTop = true;
        }
        if (articles.isNotEmpty) {
          articles.clear();
        }
        articles.addAll(topArticles);
      },
    );
  }

  Future _getArticles() {
    return DioUtil().requestNetwork(
      Method.get,
      Constant.homeArticles(0),
      onSuccess: (data) {
        homeArticles.value = mainArticlesFromJson(data);
        articles.addAll(homeArticles.value.articles);
      },
    );
  }

  Future _getBanner() {
    return DioUtil().requestNetwork(
      Method.get,
      Constant.banner,
      onSuccess: (data) {
        if (bannerItems.isNotEmpty) {
          bannerItems.clear();
        }
        bannerItems.addAll(bannerFromJson(data.toString()));
        bannerTitle.value = bannerItems[0].title;
      },
    );
  }
}
