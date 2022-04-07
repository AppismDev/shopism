import 'package:flutter/material.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Widgets/Cart/cart_card.dart';

class CartPageView extends StatefulWidget {
  const CartPageView({Key? key}) : super(key: key);

  @override
  State<CartPageView> createState() => _CartPageViewState();
}

//TODO direk card da dismissible olabilir
class _CartPageViewState extends State<CartPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.dynamicHeight(0.09),
        centerTitle: true,
        title: Text(
          "My Cart",
          style: context.appTheme.textTheme.headline4
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) {
                return CartCard();
              },
            ),
          ),
          // ElevatedButton(onPressed: () {}, child: Text("asdsad"))
        ],
      ),
    );
  }
}
