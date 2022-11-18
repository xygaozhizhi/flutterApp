import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/controller/project_controller.dart';
import '../../controller/app_controller.dart';
import '../../models/articles_tab.dart';
import '../../res/app_theme.dart';
import '../../widgets/dialog_utils.dart';
import '../../widgets/empty.dart';
import '../../widgets/load_state.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectState();
}

class _ProjectState extends State<ProjectPage> with TickerProviderStateMixin {
  late ProjectController controller;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ProjectController>();
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
          return _projectWidget();
        case LoadState.failure:
          return const EmptyPage(tipMsg: "网络异常");
        case LoadState.noMore:
          return const EmptyPage(tipMsg: "没有更多");
        case LoadState.empty:
          return const EmptyPage(tipMsg: "没有数据");
      }
    });
  }

  Widget _projectWidget() {
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
                projectTab: e,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class ArticlesPage extends StatefulWidget {
  final ArticlesTab projectTab;

  const ArticlesPage({super.key, required this.projectTab});

  @override
  State<ArticlesPage> createState() => _ArticlesState();
}

class _ArticlesState extends State<ArticlesPage>
    with AutomaticKeepAliveClientMixin {
  late ProjectController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ProjectController>();
    controller.getTabArticles(widget.projectTab.id, 0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Obx(() {
      switch (controller.loadState[widget.projectTab.id]!) {
        case LoadState.loading:
        case LoadState.empty:
          return const EmptyPage(tipMsg: "没有数据");
        case LoadState.success:
          return ListView.builder(
            itemCount: controller.allArticles[widget.projectTab.id]!.length,
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
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 136,
                  width: 128,
                  child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: controller
                          .allArticles[widget.projectTab.id]![index]
                          .envelopePic!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.allArticles[widget.projectTab.id]![index]
                              .title ??
                          "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      controller
                              .allArticles[widget.projectTab.id]![index].desc ??
                          "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          controller.allArticles[widget.projectTab.id]![index]
                                  .author.isNotEmpty
                              ? controller
                                  .allArticles[widget.projectTab.id]![index]
                                  .author
                              : controller
                                  .allArticles[widget.projectTab.id]![index]
                                  .shareUser,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Text(
                          controller.allArticles[widget.projectTab.id]![index]
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
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.favorite_outline,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
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
