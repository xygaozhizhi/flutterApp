import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/common/constant.dart';
import 'package:myflutterapp/res/icon_fonts.dart';
import 'package:myflutterapp/config/route_configs.dart';
import 'package:myflutterapp/controller/app_controller.dart';
import 'package:myflutterapp/controller/main_controller.dart';
import 'package:myflutterapp/routes/home/home_page.dart';
import 'package:myflutterapp/routes/project/project_page.dart';
import 'package:myflutterapp/routes/public/public_page.dart';
import 'package:myflutterapp/routes/square/square_page.dart';
import 'package:myflutterapp/routes/system/system_page.dart';
import 'package:myflutterapp/res/app_theme.dart';
import '../res/res_string.dart';

class MainRoute extends StatefulWidget {
  final _tabs = [
    BottomNavigationBarItem(
      label: home.tr,
      icon: const Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      label: square.tr,
      icon: const Icon(Icons.airplay),
    ),
    BottomNavigationBarItem(
      label: public.tr,
      icon: const Icon(IconFont.weChat),
    ),
    BottomNavigationBarItem(
      label: system.tr,
      icon: const Icon(Icons.account_tree),
    ),
    BottomNavigationBarItem(
      label: project.tr,
      icon: const Icon(Icons.file_copy),
    ),
  ];
  final List<Widget> _pages = [
    const HomePage(),
    const SquarePage(),
    const PublicPage(),
    SystemPage(),
    const ProjectPage(),
  ];

  MainRoute({Key? key}) : super(key: key);

  @override
  State<MainRoute> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  final controller = Get.find<MainController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title.value)),
        actions: [
          Obx(() {
            return IconButton(
              onPressed: () {
                if (controller.title.value != public) {
                } else {}
              },
              icon: Icon(
                controller.title.value == square.tr ? Icons.add : Icons.search,
                color: Colors.white,
              ),
            );
          }),
        ],
      ),
      drawer: Drawer(
        child: _drawMenu(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widget._tabs,
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
            _pageController.jumpToPage(_pageIndex);
            controller.getTitle(_pageIndex);
          });
        },
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: widget._pages,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _drawMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Obx(
          () => Container(
            padding: EdgeInsets.only(
              top: Get.mediaQuery.padding.top,
            ),
            color: getThemeData(appController.theme.value).primaryColor,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  right: 8,
                  top: 0,
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed(RoutesConfig.score);
                    },
                    icon: const Icon(
                      Icons.vertical_distribute,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          Constant.icDefaultAvatar,
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        goLogin.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        '${grade.tr}:-- ${ranking.tr}:--',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            ListTile(
              style: ListTileStyle.drawer,
              title: Text(
                myIntegral.tr,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(
                Icons.grade_outlined,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                myCollect.tr,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(
                Icons.favorite_border,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                myShare.tr,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(
                Icons.share,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                myTodo.tr,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(
                Icons.note_add,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                nightMode.tr,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: Obx(
                () => Icon(
                  appController.themeModel.value == Constant.lightThemeModel
                      ? Icons.light_mode
                      : Icons.dark_mode_outlined,
                ),
              ),
              onTap: () {
                controller.changeTheme();
              },
            ),
            ListTile(
              title: Text(
                systemSettings.tr,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(
                Icons.settings,
              ),
              onTap: () => Get.toNamed(RoutesConfig.setting),
            ),
          ],
        ),
      ],
    );
  }
}
