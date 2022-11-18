import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/res/res_string.dart';
import 'package:myflutterapp/widgets/dialog_utils.dart';
import 'package:myflutterapp/widgets/empty.dart';
import 'package:myflutterapp/widgets/my_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controller/home_controller.dart';
import '../../widgets/load_state.dart';
import '../../widgets/swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;
  late SwiperController swiperController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<HomeController>();
    swiperController = SwiperController();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.loadState.value) {
        case LoadState.loading:
          return const LoadingDialog();
        case LoadState.success:
          return _homeWidget();
        case LoadState.failure:
          return const EmptyPage(
            tipMsg: "加载失败",
          );
        case LoadState.noMore:
          return const EmptyPage(
            tipMsg: '',
          );
        case LoadState.empty:
          return const EmptyPage(
            tipMsg: "没有数据",
          );
      }
    });
  }

  Widget _homeWidget() {
    return SmartRefresher(
      controller: RefreshController(),
      enablePullUp: true,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Obx(
                () => _itemBanner(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _itemArticle(index);
              },
              childCount: controller.articles.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemBanner() {
    return Stack(
      children: [
        Positioned(
          child: Swiper(
            controller: swiperController,
            autoStart: true,
            indicator: CircleSwiperIndicator(
              itemColor: Colors.black54,
              itemActiveColor: Colors.blueAccent,
            ),
            indicatorAlignment: AlignmentDirectional.bottomEnd,
            children: controller.bannerItems
                .map((e) => CachedNetworkImage(
                      imageUrl: e.imagePath,
                      fit: BoxFit.fill,
                    ))
                .toList(),
            onChanged: (index) {
              controller.bannerTitle.value =
                  controller.bannerItems[index].title;
            },
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          height: 32,
          bottom: 0,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.black26,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                ),
                child: Text(
                  controller.bannerTitle.value,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
                    visible: controller.articles[index].isTop ||
                        controller.articles[index].fresh,
                    child: Row(
                      children: [
                        HollowFrameText(
                          radius: 4,
                          slideColor: Colors.red,
                          padding: const EdgeInsets.all(4),
                          text: controller.articles[index].isTop
                              ? top.tr
                              : controller.articles[index].fresh
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
    );
  }
}
