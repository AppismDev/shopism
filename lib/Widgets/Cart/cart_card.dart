import 'package:flutter/material.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Dismissible(
        background: buildDismissibleBackground(),
        secondaryBackground: buildDismissibleSecondaryBackground(),
        key: ValueKey("card"),
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
                  color: Colors.red,
                  child: Image.network(
                    "${widget.product.imageURL ?? "https://innovating.capital/wp-content/uploads/2021/05/vertical-placeholder-image.jpg"},",
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network("https://innovating.capital/wp-content/uploads/2021/05/vertical-placeholder-image.jpg",
                        fit: BoxFit.fitWidth,
                      );
                    },
                    height: double.infinity,
                    fit: BoxFit.fitWidth,
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${widget.product.quantity} adet",
                    style: context.appTheme.textTheme.subtitle2,
                  ),
                ),
                Text(
                  "\$8.89",
                  style: context.appTheme.textTheme.subtitle2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Card buildDismissibleSecondaryBackground() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: borderRadius,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.cancel_outlined),
        ),
      ),
    );
  }

  Card buildDismissibleBackground() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: borderRadius,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}
