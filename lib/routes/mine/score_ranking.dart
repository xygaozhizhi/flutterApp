import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/res/res_string.dart';
import '../../controller/score_ranking_controller.dart';
import '../../refresh/src/smart_refresher.dart';
import '../../widgets/dialog_utils.dart';
import '../../widgets/empty.dart';
import '../../widgets/load_state.dart';

class ScoreRankingPage extends StatefulWidget {
  const ScoreRankingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScoreRankingPageState();
}

class _ScoreRankingPageState extends State<ScoreRankingPage> {
  late ScoreRankingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ScoreRankingController>();
    controller.getData(LoadModel.loading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scoreRanking.tr),
      ),
      body: Center(
        child: Obx(() {
          switch (controller.loadState.value) {
            case LoadState.loading:
              return const LoadingDialog();
            case LoadState.success:
              return _scoreRankingWidget();
            case LoadState.failure:
              return EmptyPage(
                tipMsg: loadFail.tr,
                needRefresh: true,
                onPressed: () {
                  controller.loadState.value = LoadState.loading;
                  controller.getData(LoadModel.loading);
                },
              );
            case LoadState.empty:
              return EmptyPage(
                tipMsg: noData.tr,
                needRefresh: false,
              );
          }
        }),
      ),
    );
  }

  Widget _scoreRankingWidget() {
    return SmartRefresher(
      controller: controller.refreshController,
      enablePullUp: true,
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      child: ListView.separated(
        itemCount: controller.scores.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  controller.scores[index].rank ?? "-1",
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(
                  width: 24,
                ),
                Text(
                  controller.scores[index].username ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  "${controller.scores[index].coinCount ?? 0}",
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            color: Colors.black54,
          );
        },
      ),
    );
  }

  void _onLoadMore() {
    controller.loadPage += 1;
    controller.getData(LoadModel.loadMore);
  }

  void _onRefresh() {
    controller.loadPage = 1;
    controller.getData(LoadModel.refresh);
  }
}
