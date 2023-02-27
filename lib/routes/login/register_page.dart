import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/controller/login_controller.dart';
import 'package:myflutterapp/res/res_string.dart';

import '../../common/constant.dart';
import '../../config/route_configs.dart';
import '../../controller/app_controller.dart';
import '../../res/app_theme.dart';
import '../../utils/sp_utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();

  late LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(register.tr),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                registerUser.tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                registerTip.tr,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        labelText: userName.tr,
                        hintText: userName.tr,
                        icon: const Icon(Icons.person),
                      ),
                      // 校验用户名
                      validator: (v) {
                        return v!.trim().isNotEmpty
                            ? null
                            : userNameNotEmpty.tr;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: password.tr,
                        hintText: password.tr,
                        icon: const Icon(Icons.lock),
                      ),
                      obscureText: true,
                      //校验密码
                      validator: (v) {
                        return v!.trim().isNotEmpty
                            ? null
                            : passwordNotEmpty.tr;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordAgainController,
                      decoration: InputDecoration(
                        labelText: password.tr,
                        hintText: inputPasswordAgain.tr,
                        icon: const Icon(Icons.lock),
                      ),
                      obscureText: true,
                      //校验密码
                      validator: (v) {
                        return v!.trim().isNotEmpty
                            ? null
                            : passwordNotEmpty.tr;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextButton(
                onPressed: () async {
                  if ((_formKey.currentState as FormState).validate()) {
                    Map<String, String> params = <String, String>{};
                    params["username"] = _userNameController.text;
                    params["password"] = _passwordController.text;
                    params["repassword"] = _passwordAgainController.text;
                    await controller.register(params).then((value) {
                      Get.offNamed(RoutesConfig.login);
                      SpUtil.putString(
                          Constant.userName, _userNameController.text);
                      SpUtil.putString(
                          Constant.password, _passwordController.text);
                    });
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  color: getThemeData(appController.theme.value).primaryColor,
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    register.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    hasAccentToLogin.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                onTap: () {
                  Get.offNamed(RoutesConfig.login);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
