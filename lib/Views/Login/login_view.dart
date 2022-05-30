import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Core/Extensions/string_extensions.dart';
import 'package:shopism/Models/User/login_model.dart';
import 'package:shopism/Views/Signup/signup_view.dart';
import 'package:shopism/Widgets/SnackBar/snackbar_content.dart';

import '../../Controllers/user_controller.dart';
import '../../Core/Constants/Enums/getx_keys.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController = Get.find(tag: GetxKeys.USER_CONTROLLER.toString());
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
                  "Giriş Yap",
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
        validator: (text) => text!.isValidEmail() ? null : "Geçersiz email",
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
      child: Obx(() => TextFormField(
        obscureText: _userController.isLoginPasswordHidden.value,
        validator: (text) => text!.isLessThanThreeCharacters() ? "Geçersiz şifre" : null,
        controller: _passwordController,
        decoration: InputDecoration(
          icon: Icon(Feather.lock),
          suffixIcon: IconButton(
            icon: Icon(_userController.isLoginPasswordHidden.value ? Feather.eye_off : Feather.eye),
            onPressed: () {
              _userController.toggleLoginPasswordHidden();
            },
          ),
          hintText: "Şifre",
        ),
      )),
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
        onPressed: () async {
          bool isLogged = await _userController.login(LoginModel(email: _emailController.text, password: _passwordController.text));
          if (!isLogged) {
            ScaffoldMessenger.of(context).showSnackBar(
              context.customSnackbar(
                title: "Giriş Başarısız",
                subtitle: "Giriş yapılırken bir hata oluştu. Lütfen tekrar deneyin",
                icon: Icon(
                  AntDesign.closecircleo,
                  color: Colors.red,
                ),
                borderColor: Colors.red,
              ),
            );
          }
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
              : Text("Giriş Yap"),
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
                'Shopism\'de yeni misin?  ',
            style: context.theme.textTheme.bodyMedium,
            children: <WidgetSpan>[
              WidgetSpan(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupView(),
                    ),
                  ),
                  child: Text(
                    'Kayıt Ol',
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
