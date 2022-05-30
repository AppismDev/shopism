import 'package:get/get.dart';
import 'package:shopism/Controllers/user_controller.dart';
import 'package:shopism/Core/Utils/utils.dart';
import 'package:shopism/Models/Cart/cart_model.dart';
import 'package:shopism/Models/Delivery/delivery_model.dart';
import 'package:shopism/Models/Installment/installment_model.dart';
import 'package:shopism/Services/HTTPService/ShopIsmAPIservice/shopism_api_service.dart';

import '../Core/Constants/Enums/getx_keys.dart';

class CompleteOrderController extends GetxController {
  RxBool isShippingLoading = false.obs;
  RxBool isOrderLoading = false.obs;
  RxList<DeliveryModel> deliveries = <DeliveryModel>[].obs;
  ShopismAPIService _shopismAPIService = ShopismAPIService.instance;
  final UserController _userController = Get.find(tag: GetxKeys.USER_CONTROLLER.toString());
  Utils _utils = Utils.instance;

  RxString selectedPaymentOptions = Utils.creditCart.obs;

  RxInt selectedShippingIndex = 0.obs;
  RxInt selectedInstallment = 1.obs;

  Future<void> getShippingServices() async {
    if (deliveries.isEmpty) {
      isShippingLoading.value = true;
      List<DeliveryModel>? _deliveries = await _shopismAPIService.getDeliveries();

      if (_deliveries != null) {
        deliveries.value = _deliveries;
      }

      isShippingLoading.value = false;
    }
  }

  Future<bool> completeOrder(CartModel cartModel, Installment installment) async {
    print(cartModel.cartItem);
    isOrderLoading.value = true;
    bool isOrdered = await _shopismAPIService.completeOrder(
        _userController.user.value!, cartModel, deliveries.value[selectedShippingIndex.value].deliveryID!, installment);
    isOrderLoading.value = false;
    return isOrdered;
  }
}
