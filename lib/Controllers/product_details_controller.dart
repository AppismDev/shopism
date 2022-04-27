import 'package:get/get.dart';
import 'package:shopism/Services/HTTPService/ShopIsmAPIservice/shopism_api_service.dart';

class ProductDetailsController extends GetxController {
  ShopismAPIService _shopismAPIService = ShopismAPIService.instance;
  RxBool isAddingToCard = false.obs;
  RxInt productCount = 1.obs;

  void refreshController(){
    isAddingToCard.value = false;
    productCount.value = 1;
  }



  Future<void> addProductToCart(int productID, int count, String email) async {
    isAddingToCard.value = true;
    try {
      await _shopismAPIService.addProductToCart(productID, count, email);
    } catch (err) {
      print("error addproducttocard: " + err.toString());
    } finally {
      isAddingToCard.value = false;
    }
  }
}
