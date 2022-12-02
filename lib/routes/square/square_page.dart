import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/res_string.dart';
import '../../../widgets/dialog_utils.dart';
import '../../../widgets/empty.dart';
import '../../../widgets/load_state.dart';
import '../../../widgets/my_widget.dart';
import '../../config/route_configs.dart';
import '../../controller/square_controller.dart';
import '../../refresh/src/smart_refresher.dart';
import '../webview_page.dart';

class SquarePage extends StatefulWidget {
  const SquarePage({Key? key}) : super(key: key);

  @override
  State<SquarePage> createState() => _SquareState();
}

class _SquareState extends State<SquarePage> {
  late SquareController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<SquareController>();
    controller.getData(LoadModel.loading);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.loadState.value) {
        case LoadState.loading:
          return const LoadingDialog();
        case LoadState.success:
          return _squareWidget();
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
    });
  }

  Widget _squareWidget() {
    return SmartRefresher(
      controller: controller.refreshController,
      enablePullUp: true,
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      child: ListView.builder(
        itemCount: controller.articles.length,
        itemBuilder: (context, index) {
          return _itemArticle(index);
        },
      ),
    );
  }

  Widget _itemArticle(int index) {
    return GestureDetector(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Visibility(
                      visible: controller.articles[index].fresh,
                      child: Row(
                        children: [
                          HollowFrameText(
                            radius: 4,
                            slideColor: Colors.red,
                            padding: const EdgeInsets.all(4),
                            text: controller.articles[index].fresh
                                ? newArticles.tr
                                : "",
                            textColor: Colors.red,
                            textSize: 8,
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.articles[index].tags.isNotEmpty,
                      child: Row(
                        children: [
                          HollowFrameText(
                            radius: 4,
                            slideColor: Colors.blueAccent,
                            padding: const EdgeInsets.all(4),
                            text: controller.articles[index].tags.isEmpty
                                ? ""
                                : controller.articles[index].tags[0].name,
                            textColor: Colors.blueAccent,
                            textSize: 8,
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ),
                    Text(
                      controller.articles[index].author.isNotEmpty
                          ? controller.articles[index].author
                          : controller.articles[index].shareUser,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Text(
                      controller.articles[index].niceDate ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  controller.articles[index].title ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Text(
                      "${controller.articles[index].superChapterName}/${controller.articles[index].chapterName}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    const Icon(
                      Icons.favorite_outline,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.black,
          ),
        ],
      ),
      onTap: () {
        var title = controller.articles[index].title;
        var url = controller.articles[index].link;
        Get.toNamed("${RoutesConfig.webview}?$webTitle=$title&$webUrl=$url");
      },
    );
  }

  void _onLoadMore() {
    controller.loadPage += 1;
    controller.getData(LoadModel.loadMore);
  }

  void _onRefresh() {
    controller.loadPage = 0;
    controller.getData(LoadModel.refresh);
  }
}
