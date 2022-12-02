import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/controller/project_controller.dart';
import 'package:myflutterapp/refresh/pull_to_refresh.dart';
import '../../config/route_configs.dart';
import '../../controller/app_controller.dart';
import '../../models/articles_tab.dart';
import '../../res/app_theme.dart';
import '../../res/res_string.dart';
import '../../widgets/dialog_utils.dart';
import '../../widgets/empty.dart';
import '../../widgets/load_state.dart';
import '../webview_page.dart';

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
    controller.getTabs();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.tabState.value) {
        case LoadState.loading:
          return const LoadingDialog();
        case LoadState.success:
          tabController =
              TabController(length: controller.tabs.length, vsync: this);
          return _projectWidget();
        case LoadState.failure:
          return EmptyPage(
            tipMsg: loadFail.tr,
            needRefresh: true,
            onPressed: () {
              controller.tabState.value = LoadState.loading;
              controller.getTabs();
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

  const ArticlesPage({Key? key, required this.projectTab}) : super(key: key);

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
    controller.getTabArticles(LoadModel.loading, widget.projectTab.id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      switch (controller.loadState[widget.projectTab.id]!) {
        case LoadState.loading:
          return const LoadingDialog();
        case LoadState.empty:
          return EmptyPage(
            tipMsg: noData.tr,
            needRefresh: false,
          );
        case LoadState.success:
          return SmartRefresher(
            controller: controller.tabRefreshController[widget.projectTab.id]!,
            onRefresh: _onRefresh,
            onLoading: _onLoadMore,
            enablePullUp: true,
            child: ListView.builder(
              itemCount: controller.allArticles[widget.projectTab.id]!.length,
              itemBuilder: (context, index) {
                return _itemArticle(index);
              },
            ),
          );
        case LoadState.failure:
          return EmptyPage(
            tipMsg: loadFail.tr,
            needRefresh: false,
            onPressed: () {
              controller.loadState[widget.projectTab.id] != LoadState.loading;
              controller.tabPage[widget.projectTab.id] = 1;
              controller.getTabArticles(
                  LoadModel.loading, widget.projectTab.id);
            },
          );
      }
    });
  }

  Widget _itemArticle(int index) {
    return GestureDetector(
      child: Column(
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
                        controller.allArticles[widget.projectTab.id]![index]
                                .desc ??
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
      ),
      onTap: () {
        var title = controller.allArticles[widget.projectTab.id]![index].title;
        var url = controller.allArticles[widget.projectTab.id]![index].link;
        Get.toNamed("${RoutesConfig.webview}?$webTitle=$title&$webUrl=$url");
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onLoadMore() {
    controller.tabPage[widget.projectTab.id] =
        controller.tabPage[widget.projectTab.id]! + 1;
    controller.getTabArticles(LoadModel.loadMore, widget.projectTab.id);
  }

  void _onRefresh() {
    controller.tabPage[widget.projectTab.id] = 1;
    controller.getTabArticles(LoadModel.refresh, widget.projectTab.id);
  }
}
