import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopism/Controllers/cart_page_controller.dart';
import 'package:shopism/Controllers/complete_order_page_controller.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Core/Utils/utils.dart';
import 'package:shopism/Models/Cart/cart_model.dart';
import 'package:shopism/Models/Installment/installment_model.dart';
import 'package:shopism/Views/OrderSuccess/order_success.dart';
import 'package:shopism/Views/Tab/View/tab_page_view.dart';
import 'package:shopism/Widgets/SelectableCard/selectable_card.dart';
import 'package:shopism/Widgets/SnackBar/snackbar_content.dart';

class CompleteOrder extends StatefulWidget {
  CompleteOrder({Key? key, required this.cartModel}) : super(key: key);
  CartModel cartModel;

  @override
  State<CompleteOrder> createState() => _CompleteOrderState();
}

class _CompleteOrderState extends State<CompleteOrder> {
  CompleteOrderController _completeOrderController = Get.put(CompleteOrderController(), tag: GetxKeys.COMPLETE_ORDER_CONTROLLER.toString());
  CartPageController _cartPageController = Get.find(tag: GetxKeys.CART_PAGE_CONTROLLER.toString());
  Utils _utils = Utils.instance;

  @override
  void initState() {
    super.initState();
    _completeOrderController.getShippingServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Toplam: ${widget.cartModel.price?.toStringAsFixed(2)}',
              style: context.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
            ),
            Obx(() {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(),
                child: _completeOrderController.isOrderLoading.value
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Siparişi Tamamla',
                      ),
                onPressed: _completeOrderController.isOrderLoading.value
                    ? null
                    : () {
                        Installment _installment = Installment(
                          paymentType: _completeOrderController.selectedPaymentOptions.value,
                          totalPrice: widget.cartModel.price,
                          installment: _completeOrderController.selectedInstallment.value,
                          installmentAmount: (widget.cartModel.price! / _completeOrderController.selectedInstallment.value),
                        );

                        _completeOrderController.completeOrder(widget.cartModel, _installment).then((value) async {
                          if (value) {
                            await _cartPageController.removeCartItem(widget.cartModel);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderSuccess(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(context.customSnackbar(
                                title: "Sipariş başarısız.",
                                icon: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                                subtitle: "Siparişiniz alınırken bir hata oluştu.",
                                borderColor: Colors.red));
                          }
                          // Get.back();
                        });
                      },
              );
            })
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Siparişi Tamamla"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Obx(() {
                if (_completeOrderController.isShippingLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "Ürün Bilgileri",
                          style: context.textTheme.headline5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Container(
                            height: 150,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 120,
                                  height: double.infinity,
                                  child: Image.network(
                                    widget.cartModel.imageURL.toString(),
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Image.network("https://innovating.capital/wp-content/uploads/2021/05/vertical-placeholder-image.jpg"),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                          child: Text(widget.cartModel.productName.toString(), style: context.textTheme.headline6),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(widget.cartModel.quantity.toString() + " adet", style: context.textTheme.subtitle2),
                                              Text("${widget.cartModel.price?.toStringAsFixed(2)} TL", style: context.textTheme.subtitle2),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "Kargo Şirketleri",
                          style: context.textTheme.headline5,
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _completeOrderController.deliveries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(
                            () => SelectableCard(
                              onTap: () {
                                _completeOrderController.selectedShippingIndex.value = index;
                              },
                              isSelected: _completeOrderController.selectedShippingIndex.value == index,
                              imageUrl: _completeOrderController.deliveries[index].imageURL!,
                              text: _completeOrderController.deliveries[index].name!,
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "Ödeme Yöntemleri",
                          style: context.textTheme.headline5,
                        ),
                      ),
                      ListTile(
                        title: Text(Utils.creditCart),
                        leading: Radio(
                          value: Utils.creditCart,
                          groupValue: _completeOrderController.selectedPaymentOptions.value,
                          onChanged: (String? value) {
                            _completeOrderController.selectedPaymentOptions.value = Utils.creditCart;
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(Utils.havale),
                        leading: Radio(
                            value: Utils.havale,
                            groupValue: _completeOrderController.selectedPaymentOptions.value,
                            onChanged: (String? value) {
                              _completeOrderController.selectedPaymentOptions.value = Utils.havale;
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "Taksit Seçenekleri",
                          style: context.textTheme.headline5,
                        ),
                      ),
                      ListTile(
                        title: Text("1 Taksit"),
                        leading: Radio(
                            value: 1,
                            groupValue: _completeOrderController.selectedInstallment.value,
                            onChanged: (int? value) {
                              _completeOrderController.selectedInstallment.value = 1;
                            }),
                      ),
                      ListTile(
                        title: Text("2 Taksit"),
                        leading: Radio(
                            value: 2,
                            groupValue: _completeOrderController.selectedInstallment.value,
                            onChanged: (int? value) {
                              _completeOrderController.selectedInstallment.value = 2;
                            }),
                      ),
                      ListTile(
                        title: Text("3 Taksit"),
                        leading: Radio(
                            value: 3,
                            groupValue: _completeOrderController.selectedInstallment.value,
                            onChanged: (int? value) {
                              _completeOrderController.selectedInstallment.value = 3;
                            }),
                      ),
                      ListTile(
                        title: Text("4 Taksit"),
                        leading: Radio(
                            value: 4,
                            groupValue: _completeOrderController.selectedInstallment.value,
                            onChanged: (int? value) {
                              _completeOrderController.selectedInstallment.value = 4;
                            }),
                      ),
                      ListTile(
                        title: Text("6 Taksit"),
                        leading: Radio(
                            value: 6,
                            groupValue: _completeOrderController.selectedInstallment.value,
                            onChanged: (int? value) {
                              _completeOrderController.selectedInstallment.value = 6;
                            }),
                      ),
                      ListTile(
                        title: Text("8 Taksit"),
                        leading: Radio(
                            value: 8,
                            groupValue: _completeOrderController.selectedInstallment.value,
                            onChanged: (int? value) {
                              _completeOrderController.selectedInstallment.value = 8;
                            }),
                      ),
                      ListTile(
                        title: Text("12 Taksit"),
                        leading: Radio(
                            value: 12,
                            groupValue: _completeOrderController.selectedInstallment.value,
                            onChanged: (int? value) {
                              _completeOrderController.selectedInstallment.value = 12;
                            }),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
