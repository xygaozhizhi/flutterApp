import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/controller/system_controller.dart';
import 'package:myflutterapp/refresh/pull_to_refresh.dart';
import 'package:myflutterapp/res/res_string.dart';
import 'package:myflutterapp/widgets/dialog_utils.dart';
import 'package:myflutterapp/widgets/empty.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../controller/app_controller.dart';
import '../../res/app_theme.dart';
import '../../widgets/load_state.dart';

class SystemPage extends StatefulWidget {
  SystemPage({Key? key}) : super(key: key);
  final tabs = [system.tr, navigation.tr];

  @override
  State<SystemPage> createState() => _SystemState();
}

class _SystemState extends State<SystemPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabs.length, vsync: this)
      ..addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          isScrollable: true,
          controller: tabController,
          indicatorColor: getThemeData(appController.theme.value).primaryColor,
          tabs: widget.tabs
              .map((e) => Tab(
                    child: Text(
                      e,
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
            children: widget.tabs.map((e) {
              if (e == widget.tabs[0]) {
                return const SystemClassifyPage();
              } else {
                return const SystemNavigationPage();
              }
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SystemClassifyPage extends StatefulWidget {
  const SystemClassifyPage({Key? key}) : super(key: key);

  @override
  State<SystemClassifyPage> createState() => _SystemClassifyState();
}

class _SystemClassifyState extends State<SystemClassifyPage>
    with AutomaticKeepAliveClientMixin {
  late SystemController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<SystemController>();
    controller.getClassify(LoadModel.loading);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      switch (controller.classifyLoadState.value) {
        case LoadState.loading:
          return const LoadingDialog();
        case LoadState.success:
          return _classifyWidget();
        case LoadState.failure:
          return EmptyPage(
            tipMsg: loadFail.tr,
            needRefresh: true,
            onPressed: () {
              controller.classifyLoadState.value = LoadState.loading;
              controller.getClassify(LoadModel.loading);
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

  @override
  bool get wantKeepAlive => true;

  Widget _classifyWidget() {
    return SmartRefresher(
      controller: controller.classifyRefreshController,
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemCount: controller.classify.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.classify[index].name ?? "",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          controller.classify[index].children!.isEmpty
                              ? const SizedBox()
                              : Wrap(
                                  spacing: 12,
                                  runSpacing: 8,
                                  children: controller.classify[index].children!
                                      .map((e) {
                                    return Text(
                                      e.name ?? "",
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                    );
                                  }).toList(),
                                ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black54,
              ),
            ],
          );
        },
      ),
    );
  }

  void _onRefresh() {
    controller.getClassify(LoadModel.refresh);
  }
}

class SystemNavigationPage extends StatefulWidget {
  const SystemNavigationPage({Key? key}) : super(key: key);

  @override
  State<SystemNavigationPage> createState() => _SystemNavigationState();
}

class _SystemNavigationState extends State<SystemNavigationPage>
    with AutomaticKeepAliveClientMixin {
  late SystemController controller;
  final ItemScrollController rightItemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    controller = Get.find<SystemController>();
    controller.getNavigation();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      switch (controller.classifyLoadState.value) {
        case LoadState.loading:
          return const LoadingDialog();
        case LoadState.success:
          return _navigationWidget();
        case LoadState.failure:
          return EmptyPage(
            tipMsg: loadFail.tr,
            needRefresh: true,
            onPressed: () {
              controller.navigationLoadState.value = LoadState.loading;
              controller.getNavigation();
            },
          );
        case LoadState.empty:
          return EmptyPage(
            tipMsg: noData.tr,
            needRefresh: true,
            onPressed: () {
              controller.navigationLoadState.value = LoadState.loading;
              controller.getNavigation();
            },
          );
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  Widget _navigationWidget() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ListView.separated(
            itemCount: controller.navigation.length,
            itemBuilder: (context, index) {
              return Obx(() {
                return GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: controller.selectIndex.value == index
                        ? Colors.white70
                        : Colors.black12,
                    child: Text(
                      controller.navigation[index].name ?? "",
                      style: TextStyle(
                        color: controller.selectIndex.value == index
                            ? getThemeData(appController.theme.value)
                                .primaryColor
                            : Colors.black,
                      ),
                    ),
                  ),
                  onTap: () async {
                    controller.selectIndex.value = index;
                    rightItemScrollController.scrollTo(
                      index: index,
                      duration: const Duration(milliseconds: 300),
                    );
                    //print(itemPositionsListener.itemPositions.value.length);
                  },
                );
              });
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.white,
                height: 1,
              );
            },
          ),
        ),
        Expanded(
          flex: 5,
          child: ScrollablePositionedList.builder(
            itemScrollController: rightItemScrollController,
            itemPositionsListener: itemPositionsListener,
            itemCount: controller.navigation.length,
            itemBuilder: (context, index) {
              return Container(
                key: controller.globalKeys[index],
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.navigation[index].name ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            controller.navigation[index].articles!.map((e) {
                          return Container(
                            color: Colors.black12,
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              e.title ?? "",
                              style: TextStyle(
                                color: Color.fromARGB(
                                  255,
                                  Random().nextInt(255),
                                  Random().nextInt(255),
                                  Random().nextInt(255),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
