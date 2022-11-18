import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/controller/public_controller.dart';
import 'package:myflutterapp/models/articles_tab.dart';
import '../../controller/app_controller.dart';
import '../../res/app_theme.dart';
import '../../res/res_string.dart';
import '../../widgets/dialog_utils.dart';
import '../../widgets/empty.dart';
import '../../widgets/load_state.dart';
import '../../widgets/my_widget.dart';

class PublicPage extends StatefulWidget {
  const PublicPage({Key? key}) : super(key: key);

  @override
  State<PublicPage> createState() => _PublicState();
}

class _PublicState extends State<PublicPage> with TickerProviderStateMixin {
  late PublicController controller;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<PublicController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.tabState.value) {
        case LoadState.loading:
          return const LoadingDialog();
        case LoadState.success:
          tabController =
              TabController(length: controller.tabs.length, vsync: this)
                ..addListener(() {});
          return _publicWidget();
        case LoadState.failure:
          return const EmptyPage(tipMsg: "网络异常");
        case LoadState.noMore:
          return const EmptyPage(tipMsg: "没有更多");
        case LoadState.empty:
          return const EmptyPage(tipMsg: "没有数据");
      }
    });
  }

  Widget _publicWidget() {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          controller: tabController,
          indicatorColor: getThemeData(appController.theme.value).primaryColor,
          tabs: controller.tabs
              .map((e) => Tab(
                    child: Text(
                      e.name,
                      style: TextStyle(
                        color: getThemeData(appController.theme.value)
                            .primaryColor,
                      ),
                    ),
                  ))
              .toList(),
        ),
        Expanded(
          flex: 1,
          child: TabBarView(
            controller: tabController,
            children: controller.tabs.map((e) {
              return ArticlesPage(
                publicTab: e,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class ArticlesPage extends StatefulWidget {
  final ArticlesTab publicTab;

  const ArticlesPage({super.key, required this.publicTab});

  @override
  State<ArticlesPage> createState() => _ArticlesState();
}

class _ArticlesState extends State<ArticlesPage>
    with AutomaticKeepAliveClientMixin {
  late PublicController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<PublicController>();
    controller.getTabArticles(widget.publicTab.id, 0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Obx(() {
      switch (controller.loadState[widget.publicTab.id]!) {
        case LoadState.loading:
        case LoadState.empty:
          return const EmptyPage(tipMsg: "没有数据");
        case LoadState.success:
          return ListView.builder(
            itemCount: controller.allArticles[widget.publicTab.id]!.length,
            itemBuilder: (context, index) {
              return _itemArticle(index);
            },
          );
        case LoadState.failure:
          return const EmptyPage(tipMsg: "网络异常");
        case LoadState.noMore:
          return const EmptyPage(tipMsg: "没有更多");
      }
    });
  }

  Widget _itemArticle(int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Visibility(
                    visible: controller
                        .allArticles[widget.publicTab.id]![index].fresh,
                    child: Row(
                      children: [
                        HollowFrameText(
                          radius: 4,
                          slideColor: Colors.red,
                          padding: const EdgeInsets.all(4),
                          text: controller
                                  .allArticles[widget.publicTab.id]![index]
                                  .fresh
                              ? newArticles.tr
                              : "",
                          textColor: Colors.red,
                          textSize: 8,
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                  Text(
                    controller.allArticles[widget.publicTab.id]![index].author
                            .isNotEmpty
                        ? controller
                            .allArticles[widget.publicTab.id]![index].author
                        : controller
                            .allArticles[widget.publicTab.id]![index].shareUser,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    controller.allArticles[widget.publicTab.id]![index]
                            .niceDate ??
                        "",
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
                controller.allArticles[widget.publicTab.id]![index].title ?? "",
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
                    "${controller.allArticles[widget.publicTab.id]![index].superChapterName}/${controller.allArticles[widget.publicTab.id]![index].chapterName}",
                    style: const TextStyle(
                      color: Colors.black,
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
