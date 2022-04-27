import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Core/Extensions/string_extensions.dart';
import 'package:shopism/Models/User/login_model.dart';
import 'package:shopism/Views/Signup/signup_view.dart';

import '../../Controllers/user_controller.dart';
import '../../Core/Constants/Enums/getx_keys.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  UserController _userController = Get.find(tag: GetxKeys.USER_CONTROLLER.toString());

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Lottie.asset("assets/lottie/login_lottie.json", height: 300),
              ),
              Padding(
                padding: context.paddingOnlyLeftMedium,
                child: Text(
                  "Login",
                  style: context.appTheme.textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              // name surname email password tcno phone
              Padding(
                padding: context.paddingOnlyTopLow,
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildEmailForm(context),
                      buildPasswordForm(context),
                      buildLoginButton(context),
                      buildHaveAnAccount(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildEmailForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mediumValue, vertical: context.lowValue),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (text) => text!.isValidEmail() ? null : "Please enter a valid email",
        controller: _emailController,
        decoration: InputDecoration(
          icon: Icon(Ionicons.mail_outline),
          hintText: "Email",
        ),
      ),
    );
  }

  Padding buildPasswordForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mediumValue, vertical: context.lowValue),
      child: TextFormField(
        validator: (text) => text!.isLessThanThreeCharacters() ? "Please enter a password more than 3 characters" : null,
        controller: _passwordController,
        decoration: InputDecoration(
          icon: Icon(Feather.lock),
          hintText: "Password",
        ),
      ),
    );
  }

  Padding buildLoginButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.mediumValue, right: context.mediumValue, top: context.mediumValue),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          _userController.login(LoginModel(email: _emailController.text, password: _passwordController.text));
        },
        child: Obx(
          () => _userController.isLoginLoading.value
              ? SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ))
              : Text("Login"),
        ),
      ),
    );
  }

  Padding buildHaveAnAccount(BuildContext context) {
    return Padding(
      padding: context.paddingVerticalMedium,
      child: Align(
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            text: ''
                'New to Shopism?  ',
            style: context.theme.textTheme.bodyMedium,
            children: <WidgetSpan>[
              WidgetSpan(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupView(),
                    ),
                  ),
                  child: Text(
                    'Sign up',
                    style: context.appTheme.textTheme.bodyMedium?.copyWith(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
