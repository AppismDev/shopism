import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopism/Controllers/order_details_controller.dart';
import 'package:shopism/Controllers/user_controller.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  OrderDetailsController _controller = Get.put(OrderDetailsController(), tag: GetxKeys.ORDER_DETAILS_CONTROLLER.toString());

  @override
  void initState() {
    super.initState();
    UserController _userController = Get.find<UserController>(tag: GetxKeys.USER_CONTROLLER.toString());
    _controller.getOrderDetails(_userController.user.value?.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Obx(
        () {
          if (_controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _controller.orderDetails.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  height: 160,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120,
                          height: double.infinity,
                          child: Image.network(
                            "${_controller.orderDetails[index].cartItemDetails?.product?.productImage}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                "https://innovating.capital/wp-content/uploads/2021/05/vertical-placeholder-image.jpg",
                                fit: BoxFit.fill,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${_controller.orderDetails[index].cartItemDetails?.product?.productName?.trim()}",
                                        style: context.textTheme.headline6,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "${_controller.orderDetails[index].statusDetails?.deliveryName}",
                                        style: context.textTheme.subtitle1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //check if product price and product quantity is null
                                    if (_controller.orderDetails[index].cartItemDetails?.product?.productPrice != null &&
                                        _controller.orderDetails[index].cartItemDetails?.itemQuantity != null)
                                      Text(
                                        "${(_controller.orderDetails[index].cartItemDetails!.product!.productPrice! * _controller.orderDetails[index].cartItemDetails!.itemQuantity!).toStringAsFixed(2)}",
                                        style: context.textTheme.subtitle1,
                                      ),

                                    Text(
                                      "${_controller.orderDetails[index].statusDetails?.deliveryStatus}",
                                      style: context.textTheme.subtitle2,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
