import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/widgets/dialog_utils.dart';
import 'package:myflutterapp/widgets/empty.dart';
import 'package:myflutterapp/widgets/my_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controller/home_controller.dart';
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
    return FutureBuilder(
        future: controller.getBanner(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const EmptyPage();
            } else {
              return _homeWidget();
            }
          } else {
            return const LoadingDialog();
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
              child: Stack(
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
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors:[Colors.red,Colors.orange.shade700]), //背景渐变
                        borderRadius: BorderRadius.circular(3.0), //3像素圆角
                        boxShadow: [ //阴影
                          BoxShadow(
                              color:Colors.black54,
                              offset: Offset(2.0,2.0),
                              blurRadius: 4.0
                          )
                        ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                      child: Text("Login", style: TextStyle(color: Colors.lightBlue[100 * ((index % 9) + 1)]),),
                    )
                );
              },
              childCount: controller.articles.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemArticle() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Visibility(child: HollowFrameText()),
        ],
      ),
    );
  }
}
