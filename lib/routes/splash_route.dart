import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/common/constant.dart';
import 'package:myflutterapp/config/route_configs.dart';
import 'package:myflutterapp/res/app_theme.dart';
import '../controller/app_controller.dart';

class SplashRoute extends StatefulWidget {
  const SplashRoute({Key? key}) : super(key: key);

  @override
  State<SplashRoute> createState() => _SplashState();
}

class _SplashState extends State<SplashRoute>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;
  late MaterialColor color;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    color =
        getThemeData(appController.theme.value).primaryColor as MaterialColor;
    animation = ColorTween(begin: color[100], end: color[700])
        .animate(animationController);
    animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Get.offNamed(RoutesConfig.main);
        }
      },
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationSplash(
      animation: animation,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class AnimationSplash extends AnimatedWidget {
  const AnimationSplash({Key? key, required Animation animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation;
    return Container(
      color: animation.value,
      child: const Image(
        image: AssetImage(Constant.icLauncher),
      ),
    );
  }
}
