import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopism/Controllers/home_page_controller.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Widgets/Home/popular_product_card.dart';

class AllProductsView extends StatelessWidget {
  AllProductsView({Key? key}) : super(key: key);
  HomePageController _homePageController = Get.find(tag: GetxKeys.HOME_PAGE_CONTEROLLER.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "All Products",
                    style: context.appTheme.textTheme.headline5,
                  ),
                ),
                GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _homePageController.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 230
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        child: PopularProductCard(product: _homePageController.products[index]),
                      );
                    })              ],
            ),
          ),
        ),
      ),
    );
  }
}
