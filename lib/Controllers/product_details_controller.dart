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



  Future<bool> addProductToCart(int productID, int count, String email) async {
    isAddingToCard.value = true;
    try {
      bool isAdded = await _shopismAPIService.addProductToCart(productID, count, email);
      return isAdded;
    } catch (err) {
      print("error addproducttocard: " + err.toString());
      return false;
    } finally {
      isAddingToCard.value = false;
    }
  }
}
