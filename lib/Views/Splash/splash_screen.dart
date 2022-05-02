import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';
import 'package:shopism/Views/Login/login_view.dart';
import 'package:shopism/Views/Signup/signup_view.dart';
import 'package:shopism/Views/Tab/View/tab_page_view.dart';

import '../../Controllers/user_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController = Get.put(UserController(), tag: GetxKeys.USER_CONTROLLER.toString());
    _userController.getUserFromCache();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (_userController.isLogging.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (_userController.user.value != null) {
              return TabPageView();
            } else {
              return LoginView();
            }
          }
        },
      ),
    );
  }
}
