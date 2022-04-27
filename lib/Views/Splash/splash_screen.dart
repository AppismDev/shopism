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
  var _userController = Get.put(UserController(), tag: GetxKeys.USER_CONTROLLER.toString());

  @override
  void initState() {
    super.initState();
    _userController.getUserFromCache();

    // getUserFromCache
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
            //TODO signout olduktan sonra signup login butonlarına basıp giriş yapmaya çalışırsak user value null olmamasına
            //rağmen tabpageviewa yönlendirme yapmıyor bu satır çalışmıyor yani
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
