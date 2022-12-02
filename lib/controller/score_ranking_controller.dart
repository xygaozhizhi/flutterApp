import 'package:get/get.dart';
import '../common/constant.dart';
import '../http/dio_util.dart';
import '../models/score_rankings.dart';
import '../refresh/src/smart_refresher.dart';
import '../widgets/load_state.dart';

class ScoreRankingController extends GetxController {
  late RefreshController refreshController;
  var loadPage = 1;
  List<Score> scores = <Score>[].obs;
  var scoreRankings = ScoreRankings().obs;
  var loadState = LoadState.loading.obs;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController();
  }

  void getData(LoadModel loadModel) {
    DioUtil()
        .requestNetwork(Method.get, Constant.scoreRanking(loadPage))
        .then((value) {
      if (loadModel != LoadModel.loadMore && scores.isNotEmpty) {
        scores.clear();
      }
      scoreRankings.value = scoreRankingsFromJson(value);
      scores.addAll(scoreRankings.value.datas);
      if (loadModel == LoadModel.refresh) {
        refreshController.refreshCompleted(resetFooterState: true);
      } else if (loadModel == LoadModel.loading) {
        loadState.value = scores.isEmpty ? LoadState.empty : LoadState.success;
      } else {
        if ((scoreRankings.value.curPage ?? 0) <=
            (scoreRankings.value.pageCount ?? 0)) {
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
