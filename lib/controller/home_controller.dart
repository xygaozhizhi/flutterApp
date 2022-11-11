import 'package:get/get.dart';
import 'package:myflutterapp/common/constant.dart';
import 'package:myflutterapp/http/dio_util.dart';
import 'package:myflutterapp/models/banner.dart';

import '../models/articles.dart';

class HomeController extends GetxController {
  List<BannerData> bannerItems = <BannerData>[].obs;
  var homeArticles = HomeArticles().obs;
  List<Articles> articles = <Articles>[].obs;

  var bannerTitle = "".obs;

  @override
  void onInit() {
    super.onInit();
    getTopArticles();
  }

  Future getTopArticles() async {
    await DioUtil().requestNetwork(
      Method.get,
      Constant.topArticles,
      onSuccess: (data) {
        List<Articles> topArticles = articlesFromJson(data);
        for (var article in topArticles) {
          article.isTop = true;
        }
        if (articles.isEmpty) {
          articles.addAll(topArticles);
        }
        print(articles.length);
      },
    );
  }

  Future getArticles() async {
    await DioUtil().requestNetwork(
      Method.get,
      Constant.articles(1),
      onSuccess: (data) {
        homeArticles.value = homeArticlesFromJson(data);
      },
    );
  }

  Future getBanner() async {
    await DioUtil().requestNetwork(
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
