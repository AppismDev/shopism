import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopism/Controllers/cart_page_controller.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Core/Utils/utils.dart';
import 'package:shopism/Views/CompleteOrder/complete_order.dart';

import '../../Models/Cart/cart_model.dart';
import '../../Models/Product/product_model.dart';

class CartCard extends StatefulWidget {
  CartModel product;

  CartCard({Key? key, required this.product}) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  final borderRadius = BorderRadius.circular(12);
  CartPageController _cartPageController = Get.find(tag: GetxKeys.CART_PAGE_CONTROLLER.toString());
  Utils _utils = Utils.instance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteOrder(cartModel: widget.product),)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Dismissible(
          background: buildDismissibleBackground(),
          direction: DismissDirection.endToStart,
          key: ValueKey(widget.product.cartItem),
          onDismissed: (dismissDirection) async{
              //cart controller remove
            bool isRemoved = await _cartPageController.removeCartItem(widget.product);
            _cartPageController.calculateTotalCount();

          },
          child: Container(
            height: 160,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    child: Image.network(
                      "${widget.product.imageURL}",
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          "https://innovating.capital/wp-content/uploads/2021/05/vertical-placeholder-image.jpg",
                          fit: BoxFit.cover,
                        );
                      },
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: buildCardContent(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildCardContent(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.product.productName}",
            style: context.appTheme.textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
          // Text(
          //   "Organic",
          //   style: context.appTheme.textTheme.subtitle2?.copyWith(color: Colors.grey),
          // ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.price != null && widget.product.quantity != null
                      ? "\₺${(widget.product.price!).toStringAsFixed(2)}"
                      : "-",
                  style: context.appTheme.textTheme.subtitle2,
                ),
                Text(
                  "${widget.product.quantity} adet",
                  style: context.appTheme.textTheme.subtitle2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Card buildDismissibleBackground() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.cancel_outlined),
            Icon(Icons.cancel_outlined),
          ],
        ),
      ),
    );
  }
}
