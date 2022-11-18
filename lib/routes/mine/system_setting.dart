import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/common/constant.dart';
import 'package:myflutterapp/controller/app_controller.dart';
import 'package:myflutterapp/controller/system_setting_controller.dart';
import 'package:myflutterapp/res/res_string.dart';
import 'package:myflutterapp/res/app_theme.dart';
import 'package:myflutterapp/utils/sp_utils.dart';

class SettingRoute extends StatefulWidget {
  const SettingRoute({Key? key}) : super(key: key);

  @override
  State<SettingRoute> createState() => _SettingState();
}

class _SettingState extends State<SettingRoute> {
  List<Widget> themeItems = [];
  final controller = Get.find<SystemSettingController>();

  @override
  void initState() {
    super.initState();
    _initThemeWidget(themeColorData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          settings.tr,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              basicSettings.tr,
              style: const TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            style: ListTileStyle.list,
            title: Text(noImageMode.tr),
            subtitle: Text(noImageModeDesc.tr),
            trailing: Checkbox(value: false, onChanged: (value) {}),
          ),
          ListTile(
            style: ListTileStyle.list,
            title: Text(topArticleOnTheHomepage.tr),
            subtitle: Text(topArticleOnTheHomepageDesc.tr),
            trailing: Checkbox(value: false, onChanged: (value) {}),
          ),
          ListTile(
            style: ListTileStyle.list,
            title: Text(automaticallySwitchNightMode.tr),
            subtitle: Text(setTheSwitchingTime.tr),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              otherSettings.tr,
              style: const TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            style: ListTileStyle.list,
            title: Text(themeColor.tr),
            subtitle: Text(customThemeColors.tr),
            trailing: ClipOval(
              child: Obx(
                () => Container(
                  color: themeColorData[controller.themeIndex.value],
                  width: 40,
                  height: 40,
                ),
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return _showThemeDialog();
                },
              );
            },
          ),
          ListTile(
            style: ListTileStyle.list,
            title: Text(clearCache.tr),
            subtitle: const Text('20M'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              about.tr,
              style: const TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            style: ListTileStyle.list,
            title: Text(version.tr),
            subtitle: Text(currentVersion.tr),
          ),
        ],
      ),
    );
  }

  Widget _showThemeDialog() {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Align(
          heightFactor: 1.0,
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                themeColor.tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                shrinkWrap: true,
                children: themeItems,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      customize.tr,
                      style: const TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.themeIndex.value = appController.theme.value;
                      Get.back();
                    },
                    child: Text(
                      cancel.tr,
                      style: const TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      appController.theme.value = controller.themeIndex.value;
                      if (!Get.isDarkMode) {
                        Get.changeTheme(
                          getThemeData(appController.theme.value),
                        );
                      }
                      SpUtil.putInt(
                        Constant.keyTheme,
                        appController.theme.value,
                      );
                      Get.back();
                    },
                    child: Text(
                      sure.tr,
                      style: const TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initThemeWidget(List themeColor) {
    for (var i = 0; i < themeColor.length; ++i) {
      Widget item = GestureDetector(
        onTap: () {
          controller.themeIndex.value = i;
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipOval(
              child: Container(
                color: themeColor[i],
                width: 60,
                height: 60,
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.themeIndex.value == i,
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
      themeItems.add(item);
    }
  }
}
