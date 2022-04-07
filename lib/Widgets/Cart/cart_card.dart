import 'package:flutter/material.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';

class CartCard extends StatefulWidget {
  const CartCard({Key? key}) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  final borderRadius = BorderRadius.circular(12);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Dismissible(
        background: buildDismissibleBackground(),
        secondaryBackground: buildDismissibleSecondaryBackground(),
        key: ValueKey("card"),
        child: Container(
          height: context.dynamicHeight(0.15),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg",
                  width: context.dynamicWidth(0.35),
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: context.paddingAllLow,
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
            "Apple",
            style: context.appTheme.textTheme.headline6
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            "Organic",
            style: context.appTheme.textTheme.subtitle2
                ?.copyWith(color: Colors.grey),
          ),
          Padding(
            padding: context.paddingOnlyTopLow,
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
                    "1kg",
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
