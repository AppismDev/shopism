import 'package:get/get.dart';
import 'package:shopism/Models/Cart/cart_model.dart';
import 'package:shopism/Services/HTTPService/ShopIsmAPIservice/shopism_api_service.dart';

import '../Models/Product/product_model.dart';

class CartPageController extends GetxController {
  ShopismAPIService _shopismAPIService = ShopismAPIService.instance;

  RxBool isCartLoading = false.obs;
  RxBool isCartItemLoading = false.obs;
  RxList<CartModel> cartItems = <CartModel>[].obs;

  Future<void> getCartItems(String email) async {
      isCartLoading.value = true;
      List<CartModel>? _data = await _shopismAPIService.getCartItems(email);
      if (_data != null) {
        cartItems.clear();
        cartItems.addAll(_data);
      }
      isCartLoading.value = false;
  }

  Future<bool> removeCartItem(CartModel product) async{
    isCartItemLoading.value = true;

    cartItems.removeWhere((element) => element.productId == product.productId);
    return false;


  }

  // Future<void> refreshCart(String email) async{
  //   isCartLoading.value = true;
  //   List<CartModel>? _data = await _shopismAPIService.getCartItems(email);
  //   if (_data != null) {
  //     cartItems.clear();
  //     cartItems.addAll(_data);
  //   }
  //   isCartLoading.value = false;
  //
  // }
}
