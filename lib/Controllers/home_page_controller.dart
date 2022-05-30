import 'package:get/get.dart';
import 'package:shopism/Models/Category/category_model.dart';
import 'package:shopism/Services/HTTPService/ShopIsmAPIservice/shopism_api_service.dart';

import '../Models/Product/product_model.dart';

class HomePageController extends GetxController {
  ShopismAPIService _shopismAPIService = ShopismAPIService.instance;
  var categoriesLoading = false.obs;
  RxBool productsLoading = false.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<Product> products = <Product>[].obs;
  RxInt pageViewIndex = 0.obs;

  @override
  void onInit() {
    getCategories();
    getProducts();
    super.onInit();
  }

  void setPageViewIndex(int index){
    pageViewIndex.value = index;

  }
  Future<void> getCategories() async {
    categoriesLoading.value = true;
    List<CategoryModel> _categories =
        await _shopismAPIService.getAllCategories();
    categories.clear();
    categories.addAll(_categories);
    categoriesLoading.value = false;
  }

  Future<void> getProducts() async {
    productsLoading.value = true;
    List<Product> _products = await _shopismAPIService.getAllProducts();
    products.clear();
    products.addAll(_products);
    productsLoading.value = false;
  }
}
