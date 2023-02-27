import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutterapp/res/res_string.dart';

import '../../common/constant.dart';
import '../../config/route_configs.dart';
import '../../controller/app_controller.dart';
import '../../controller/login_controller.dart';
import '../../res/app_theme.dart';
import '../../utils/sp_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginController();
    String? userName = SpUtil.getString(Constant.userName);
    String? password = SpUtil.getString(Constant.password);
    _userNameController.text = userName ?? "";
    _passwordController.text = password ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(login.tr),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                userLogin.tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                loginTip.tr,
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
                    await controller.login(params).then((value) => Get.back());
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  color: getThemeData(appController.theme.value).primaryColor,
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    login.tr,
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
                    noAccentToRegister.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                onTap: () {
                  Get.offNamed(RoutesConfig.register);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
