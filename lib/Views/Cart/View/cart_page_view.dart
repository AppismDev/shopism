import 'package:flutter/material.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';

class CartPageView extends StatefulWidget {
  const CartPageView({Key? key}) : super(key: key);

  @override
  State<CartPageView> createState() => _CartPageViewState();
}

class _CartPageViewState extends State<CartPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
        ),
        centerTitle: true,
      ),
      body: Center(child: Text("cartpage")),
    );
  }
}
