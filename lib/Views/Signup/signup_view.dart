import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shopism/Controllers/user_controller.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Core/Extensions/string_extensions.dart';
import 'package:shopism/Models/User/account_model.dart';
import 'package:shopism/Views/Login/login_view.dart';

import '../../Core/Constants/Enums/getx_keys.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _idNumberController;

  late TextEditingController _phoneNumberController;
  late GlobalKey<FormState> _formKey;

  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController =  Get.find(tag: GetxKeys.USER_CONTROLLER.toString());
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _idNumberController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _idNumberController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
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
                child: Lottie.asset("assets/lottie/signup_lottie.json", height: 300),
              ),
              Padding(
                padding: context.paddingOnlyLeftMedium,
                child: Text(
                  "Sign Up",
                  style: context.appTheme.textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              // name surname email password tcno phone
              Padding(
                padding: context.paddingOnlyTopLow,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildNameForm(context),
                      buildSurnameForm(context),
                      buildEmailForm(context),
                      buildPasswordForm(context),
                      buildIDForm(context),
                      buildPhoneForm(context),
                      buildAcceptTermsText(context),
                      buildSignupButton(context),
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

  Padding buildHaveAnAccount(BuildContext context) {
    return Padding(
      padding: context.paddingVerticalMedium,
      child: Align(
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            text: 'Already have an account? ',
            style: context.theme.textTheme.bodyMedium,
            children: <WidgetSpan>[
              WidgetSpan(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Login',
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

  Padding buildSignupButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.mediumValue, right: context.mediumValue, top: context.lowValue),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            AccountModel accountModel = AccountModel(
              email: _emailController.text,
              password: _passwordController.text,
              name: _nameController.text,
              surname: _surnameController.text,
              phone: _phoneNumberController.text,
              tcno: _idNumberController.text,
            );

            _userController.signup(accountModel).then((value) {
              if (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  context.customSnackbar(
                    title: "Kayıt Başarılı",
                    subtitle: "Kayıt başarıyla gerçekleşti. Lütfen giriş yapın.",
                    icon: Icon(
                      AntDesign.checkcircleo,
                      color: Colors.green,
                    ),
                    borderColor: Colors.green,
                  ),
                );
              } else {

                ScaffoldMessenger.of(context).showSnackBar(
                  context.customSnackbar(
                    title: "Kaydolma Başarısız",
                    subtitle: "Kayıt yapılırken bir hata oluştu. Lütfen tekrar deneyin",
                    icon: Icon(
                      AntDesign.closecircleo,
                      color: Colors.red,
                    ),
                    borderColor: Colors.red,
                  ),
                );
              }
            });
          }
        },
        child: Obx(
          () => _userController.isSignupLoading.value
              ? SizedBox(width: 25, height: 25, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
              : Text("Sign up"),
        ),
      ),
    );
  }

  Padding buildAcceptTermsText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.mediumValue,
        right: context.mediumValue,
        top: context.lowValue,
        bottom: context.lowValue,
      ),
      child: Text(
        "By signing up, you're agree to our Terms & Conditions and Privacy Policy",
        style: context.appTheme.textTheme.caption,
      ),
    );
  }

  Padding buildNameForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mediumValue, vertical: context.lowValue),
      child: TextFormField(
        validator: (text) => text!.isLessThanThreeCharacters() ? "Please enter a name more than 3 characters" : null,
        controller: _nameController,
        decoration: InputDecoration(
          icon: Icon(Ionicons.person_outline),
          hintText: "Name",
        ),
      ),
    );
  }

  Padding buildSurnameForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mediumValue, vertical: context.lowValue),
      child: TextFormField(
        validator: (text) => text!.isLessThanThreeCharacters() ? "Please enter a surname more than 3 characters" : null,
        controller: _surnameController,
        decoration: InputDecoration(
          icon: Icon(Ionicons.person_outline),
          hintText: "Surname",
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
      child: Obx(() => TextFormField(
        obscureText: _userController.isSignupPasswordHidden.value,
        validator: (text) => text!.isLessThanThreeCharacters() ? "Please enter a password more than 3 characters" : null,
        controller: _passwordController,
        decoration: InputDecoration(
          icon: Icon(Feather.lock),
          suffixIcon: IconButton(
            icon: Icon(_userController.isSignupPasswordHidden.value ? Feather.eye_off : Feather.eye),
            onPressed: () {
              _userController.toggleSignupPasswordHidden();
            },
          ),
          hintText: "Password",
        ),
      ),),
    );
  }

  Padding buildIDForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mediumValue, vertical: context.lowValue),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (text) => text!.isValidIdentityNumber() ? null : "Please enter a valid identity number",
        controller: _idNumberController,
        decoration: InputDecoration(
          icon: Icon(AntDesign.idcard),
          hintText: "Identify Number",
        ),
      ),
    );
  }

  Padding buildPhoneForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mediumValue, vertical: context.lowValue),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (text) => text!.isValidPhoneNumber() ? null : "Please enter a valid phone number",
        controller: _phoneNumberController,
        decoration: InputDecoration(
          icon: Icon(AntDesign.phone),
          hintText: "Phone Number",
        ),
      ),
    );
  }
}
