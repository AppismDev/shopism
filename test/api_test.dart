import 'package:shopism/Models/Category/category_model.dart';
import 'package:shopism/Models/Delivery/delivery_model.dart';
import 'package:shopism/Models/OrderModel/order_model.dart';
import 'package:shopism/Models/Product/product_model.dart';
import 'package:shopism/Services/HTTPService/ShopIsmAPIservice/shopism_api_service.dart';
import 'package:test/test.dart';

void main() {
  group("ShopismAPIService Test", () {
    ShopismAPIService apiService = ShopismAPIService.instance;

    test("GetAllProducts Test", () async {
      List<Product> products = await apiService.getAllProducts();

      print("Products Length : ${products.length}");
      expect(products.isNotEmpty, true);
    });

    test("GetAllCategories Test", () async {
      List<CategoryModel> categories = await apiService.getAllCategories();
      print("Categories length : ${categories.length}");
      expect(categories.isNotEmpty, true);
    });

    test("Get Cargo Text", () async {
      List<DeliveryModel>? deliveries = await apiService.getDeliveries();
      print("deliveries length : ${deliveries?.length}");
      expect(deliveries != null  && deliveries.isNotEmpty, true);
    });

    // test getMyOrders from shopism_api_service
    test("Get My Orders", () async {
      List<OrderModel>? products = await apiService.getMyOrders("ahmet@gmail.com");
      print("Products Length : ${products?.length}");
      expect(products?.isNotEmpty, true);
    });

  });
}
