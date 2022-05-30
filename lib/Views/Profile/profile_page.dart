import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:shopism/Controllers/user_controller.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Core/Utils/utils.dart';
import 'package:shopism/Widgets/SnackBar/snackbar_content.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserController _userController = Get.find(tag: GetxKeys.USER_CONTROLLER.toString());
  Utils _utils = Utils.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: context.dynamicHeight(0.1),
              ),
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(42),
                  ),
                  child: Image.network(
                    "https://www.pngitem.com/pimgs/m/99-998739_dale-engen-person-placeholder-hd-png-download.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    "${_utils.setUserNameString(_userController.user.value)}",
                    style: context.textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(blurRadius: 8, spreadRadius: 1, color: Colors.grey.shade300),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.email)),
                      title: Text(
                        "Email Adresi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${_userController.user.value?.email}"),
                    ),
                    ListTile(
                      leading: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.phone)),
                      title: Text(
                        "Telefon Numarası",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${_userController.user.value?.phone}"),
                    ),
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.flag),
                      ),
                      title: Text(
                        "Ülke",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${_userController.user.value?.country}"),
                    ),
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Entypo.address),
                      ),
                      title: Text(
                        "Teslimat Adresi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${_utils.setAddressString(_userController.user.value)}"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Obx(
                  () {
                    return OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          primary: Colors.red,
                          side: BorderSide(color: Colors.red, width: 2),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12)),
                      onPressed: () {

                        if (!_userController.isLogoutLoading.value) {
                          _userController.signOut();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Text("Çıkış Yap"),
                          if (_userController.isLogoutLoading.value) ...[
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          ] else ...[
                            Icon(Icons.exit_to_app),
                          ]
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
