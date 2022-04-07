import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopism/Views/Signup/signup_view.dart';
import 'package:shopism/Views/Tab/View/tab_page_view.dart';

import '../../Controllers/UserController.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    // getUserFromCache
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_userController.isLogging.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (_userController.isLogged.value) {
            return TabPageView();
          } else {
            return SignupView();
          }
        }
      },
    );
  }
}
