import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shopism/Controllers/cart_page_controller.dart';
import 'package:shopism/Controllers/user_controller.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Widgets/Cart/cart_card.dart';

import '../../CompleteOrder/complete_order.dart';

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
    _cartPageController.getCartItems(_userController.user.value!.email).then((value) {
      _cartPageController.calculateTotalCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.dynamicHeight(0.09),
        centerTitle: true,
        title: Text(
          "Sepetim",
        ),
      ),
      body: Obx(
        () {
          if (_cartPageController.isCartLoading.value) {
            return LinearProgressIndicator();
          } else {
            return Column(
              children: [
                Expanded(
                  child: Obx(
                    () {
                      if (_cartPageController.cartItems.length == 0) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Lottie.asset("assets/lottie/empty-cart.json"),
                            Text(
                              "Sepetiniz Boş",
                              textAlign: TextAlign.center,
                              style: context.textTheme.headline4,
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_cartPageController.cartItems.length != 0) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _cartPageController.cartItems.length.toString() + " ürün",
                                      style: context.textTheme.headline6,
                                    ),
                                    Obx(
                                      () {
                                        if (_cartPageController.isCartItemLoading.value) {
                                          return SizedBox(width: 20,height: 20, child: CircularProgressIndicator(),);
                                        } else {
                                          return Text(
                                            "${_cartPageController.totalCount.value.toStringAsFixed(2)} TL",
                                            style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                                          );
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _cartPageController.cartItems.length,
                                itemBuilder: (context, index) {
                                  return CartCard(
                                    product: _cartPageController.cartItems[index],
                                  );
                                },
                              ),
                            ),
                            // Container(
                            //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
                            //     BoxShadow(),
                            //   ]),
                            //   child: Column(
                            //     children: [
                            //       Padding(
                            //         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             Text("TOTAL" , style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),),
                            //             Text("${_cartPageController.totalCount.value.toStringAsFixed(2)} TL", style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold)),
                            //           ],
                            //         ),
                            //       ),
                            //       Container(
                            //         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            //         width: double.infinity,
                            //         child: ElevatedButton(
                            //           style: ElevatedButton.styleFrom(
                            //             padding: EdgeInsets.symmetric(vertical: 14),
                            //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                            //           ),
                            //           onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteOrder())),
                            //           child: Text("Payment"),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ],
                        );
                      }
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
