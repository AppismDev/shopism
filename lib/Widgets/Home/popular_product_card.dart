import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:shopism/Controllers/favorites_controller.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Core/Init/Cache/favorites_cache_manager.dart';
import 'package:shopism/Core/Utils/utils.dart';
import 'package:shopism/Models/Product/product_model.dart';
import 'package:shopism/Views/HomeDetails/View/product_details.dart';
import 'package:shopism/Widgets/Drawings/discount_icon_clipper.dart';

class PopularProductCard extends StatelessWidget {
  Product product;

  PopularProductCard({Key? key, required this.product}) : super(key: key);

  Utils _utils = Utils.instance;
  FavoritesController _favoritesController = Get.find(tag: GetxKeys.FAVORITES_CONTROLLER.toString());
  FavoritesCacheManager _favoritesCacheManager = FavoritesCacheManager.instance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ProductDetails(
                product: product,
              ),
            ));
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.network(
                      product.productImage?.url ??
                          "https://toppng.com/uploads/preview/clipart-free-seaweed-clipart-draw-food-placeholder-11562968708qhzooxrjly.png",
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            _favoritesController.checkAndRemoveIfExist(product);
                          },
                          child: Icon(
                            _favoritesController.favorites.map((e) => (e as Product).productId).contains(product.productId)
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: _favoritesController.favorites.map((e) => (e as Product).productId).contains(product.productId)
                                ? Colors.red
                                : Colors.white,
                          ),
                        );
                      }),
                      if (product.productDiscountRate != null && product.productDiscountRate != 0) ...[
                        Container(
                          width: 50,
                          height: 20,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xffF25D50),
                                Color(0xffF2BB77),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "%${product.productDiscountRate}",
                              style: context.appTheme.textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ]
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${product.category?.name}",
                      style: context.appTheme.textTheme.subtitle2!.copyWith(
                        color: Colors.grey,
                      )),
                  SizedBox(
                    height: 40,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${product.productName}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.appTheme.textTheme.subtitle2!.copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        if (product.productPrice != null && product.productDiscountRate != null && product.productDiscountRate != 0) ...[
                          Text(
                            "\₺${_utils.calculateDiscountedPrice(product.productPrice!, product.productDiscountRate!.toDouble()).ceilToDouble()}",
                            style: context.appTheme.textTheme.headline6!.copyWith(color: context.appTheme.primaryColor),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                "\₺${product.productPrice}",
                                style: TextStyle(decoration: TextDecoration.lineThrough),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ] else if (product.productPrice != null && (product.productDiscountRate == null || product.productDiscountRate! == 0)) ...[
                          Text(
                            "\₺${product.productPrice!}",
                            style: context.appTheme.textTheme.headline6!.copyWith(color: context.appTheme.primaryColor),
                          )
                        ],
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
  }
}
