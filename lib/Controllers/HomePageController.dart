import 'package:get/get.dart';
import 'package:shopism/Models/Category/category_model.dart';
import 'package:shopism/Services/HTTPService/ShopIsmAPIservice/shopism_api_service.dart';

class HomePageController extends GetxController {
  ShopismAPIService _shopismAPIService = ShopismAPIService.instance;
  var categoriesLoading = false.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  void getCategories() async {
    categoriesLoading.value = true;
    List<CategoryModel> _categories =
        await _shopismAPIService.getAllCategories();
    categories.clear();
    categories.addAll(_categories);
    categoriesLoading.value = false;
  }
}
