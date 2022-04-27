import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopism/Controllers/cart_page_controller.dart';
import 'package:shopism/Controllers/user_controller.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Widgets/Cart/cart_card.dart';

class CartPageView extends StatefulWidget {
  const CartPageView({Key? key}) : super(key: key);

  @override
  State<CartPageView> createState() => _CartPageViewState();
}

//TODO direk card da dismissible olabilir
class _CartPageViewState extends State<CartPageView> {
  CartPageController _cartPageController = Get.find(tag: GetxKeys.CART_PAGE_CONTROLLER.toString());
  UserController _userController = Get.find(tag: GetxKeys.USER_CONTROLLER.toString());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartPageController.getCartItems(_userController.user.value!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.dynamicHeight(0.09),
        centerTitle: true,
        title: Text(
          "My Cart",
          style: context.appTheme.textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () {
          if(_cartPageController.isCartLoading.value){
            return LinearProgressIndicator();
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _cartPageController.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartCard(
                        product: _cartPageController.cartItems[index],
                      );
                    },
                  ),
                ),
                // ElevatedButton(onPressed: () {}, child: Text("asdsad"))
              ],
            );
          }
        },
      ),
    );
  }
}
