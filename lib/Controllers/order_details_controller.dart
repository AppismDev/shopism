import 'package:get/get.dart';
import 'package:shopism/Models/OrderModel/order_model.dart';
import 'package:shopism/Services/HTTPService/ShopIsmAPIservice/shopism_api_service.dart';

import '../Views/OrderDetails/order_details.dart';

class OrderDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<OrderModel> orderDetails = <OrderModel>[].obs;
  ShopismAPIService _apiService = ShopismAPIService.instance;

  // Get orderdetails from shopism api and set it to orderDetails
  void getOrderDetails(String? email) async {
    if(email == null) return;
    isLoading.value = true;
    var data = await _apiService.getMyOrders(email);
    if (data != null) {
      orderDetails.value = data.reversed.toList();
    }

    isLoading.value = false;
  }
}
