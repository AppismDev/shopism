import 'package:get/get.dart';
import 'package:shopism/Models/Category/category_model.dart';
import 'package:shopism/Models/Product/product_model.dart';
import 'package:shopism/Services/HTTPService/ShopIsmAPIservice/shopism_api_service.dart';

class CategoryDetailsController extends GetxController {
  ShopismAPIService _shopismAPIService = ShopismAPIService.instance;

  RxBool isProductsLoading = false.obs;
  RxList<Product> products = <Product>[].obs;


  Future<void> getCategoryItems(CategoryModel categoryModel) async {
    isProductsLoading.value = true;
    products.clear();
    try {
      List<Product> _products = await _shopismAPIService.getCategoryItems(categoryModel);
      products.addAll(_products);
      products.forEach((element) {
        print(element.productImage?.url);

      });
    } catch (err) {
      print("error categorydetails controller getx ${err}");
    } finally {
      isProductsLoading.value = false;
    }
  }
}
