import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:shopism/Controllers/favorites_controller.dart';
import 'package:shopism/Controllers/product_details_controller.dart';
import 'package:shopism/Controllers/user_controller.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Models/Product/product_model.dart';
import 'package:shopism/Core/Utils/utils.dart';

class ProductDetails extends StatefulWidget {
  Product product;

  ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Utils _utils = Utils.instance;
  ProductDetailsController _detailsController = Get.find(tag: GetxKeys.PRODUCT_DETAILS_CONTROLLER.toString());

  FavoritesController _favoritesController = Get.find(tag: GetxKeys.FAVORITES_CONTROLLER.toString());

  UserController _userController = Get.find(tag: GetxKeys.USER_CONTROLLER.toString());

  @override
  void initState() {
    // ürün sayısının aynı kalması olayı yüzünden böyle bir şey tercih ettim
    _detailsController.refreshController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: buildBottomNavBar(context),
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImageContainer(context),
            buildTitleContent(context),
            Divider(),
            buildProductCountRow(context),
            Divider(),
            buildDescriptionColumn(context)
            // Text()
          ],
        ),
      ),
    );
  }

  Padding buildDescriptionColumn(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: context.appTheme.textTheme.headline6,
          ),
          Padding(
            padding: context.paddingVerticalLow,
            child: Text(
              "${widget.product.productDescription ?? "Bu ürünün açıklaması yok."}",
              style: context.appTheme.textTheme.subtitle1!.copyWith(color: Colors.grey.shade600),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "Read more",
              style: context.appTheme.textTheme.subtitle1!.copyWith(color: context.appTheme.primaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildProductCountRow(BuildContext context) {
    return Padding(
      padding: context.paddingVerticalLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(context.paddingAllLow),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<OutlinedBorder>(CircleBorder()),
            ),
            onPressed: () {
              if (_detailsController.productCount.value > 1) {
                _detailsController.productCount.value--;
              }
            },
            child: Icon(
              Icons.remove,
              color: context.appTheme.primaryColor,
            ),
          ),
          Padding(
            padding: context.paddingHorizontalLow,
            child: Obx(
              () => Text(
                "${_detailsController.productCount.value}",
                style: context.appTheme.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(context.paddingAllLow),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<OutlinedBorder>(CircleBorder()),
            ),
            onPressed: () {
              _detailsController.productCount.value++;
            },
            child: Icon(
              Icons.add,
              color: context.appTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Padding buildTitleContent(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.product.category?.name ?? "-"}",
                  style: context.appTheme.textTheme.subtitle1!.copyWith(color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: context.paddingOnlyTopVeryLow,
                  child: Text("${widget.product.productName ?? "-"}",
                      style: context.appTheme.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold, fontSize: 26)),
                ),
                Padding(
                  padding: context.paddingOnlyTopLow,
                  child: Row(
                    children: [
                      if (widget.product.productPrice != null &&
                          widget.product.productDiscountRate != null &&
                          widget.product.productDiscountRate != 0) ...[
                        Text(
                          "\₺${_utils.calculateDiscountedPrice(widget.product.productPrice!, widget.product.productDiscountRate!.toDouble()).ceilToDouble()}",
                          style: context.appTheme.textTheme.headline5!.copyWith(color: context.appTheme.primaryColor, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            "\₺${widget.product.productPrice}",
                            style: context.appTheme.textTheme.subtitle1!
                                .copyWith(color: Colors.grey.shade700, fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough),
                          ),
                        )
                      ] else if (widget.product.productPrice != null &&
                          (widget.product.productDiscountRate == null || widget.product.productDiscountRate! == 0)) ...[
                        Text(
                          "\₺${widget.product.productPrice!}",
                          style: context.appTheme.textTheme.headline5!.copyWith(color: context.appTheme.primaryColor, fontWeight: FontWeight.bold),
                        )
                      ],
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: Obx(
                () {
                  return ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(context.paddingAllLow),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          CircleBorder(),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () {
                      _favoritesController.checkAndRemoveIfExist(widget.product);
                    },
                    child: Icon(
                      Icons.favorite,
                      color: _favoritesController.favorites.map((e) => (e as Product).productId).contains(widget.product.productId)
                          ? Colors.red
                          : Colors.grey,
                      // color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildImageContainer(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      height: context.dynamicHeight(0.6),
      child: Image.network(
        "${widget.product.productImage?.url ?? "https://innovating.capital/wp-content/uploads/2021/05/vertical-placeholder-image.jpg"}",
        fit: BoxFit.fill,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey.shade500),
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert_rounded,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Container buildBottomNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.appTheme.scaffoldBackgroundColor, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: Padding(
        padding: EdgeInsets.all(context.dynamicHeight(0.02)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () {
                    return Text(
                      widget.product.productDiscountRate == null || widget.product.productDiscountRate == 0
                          ? "${(widget.product.productPrice! * _detailsController.productCount.value).toStringAsFixed(2)}"
                          : "\₺${(_utils.calculateDiscountedPrice(widget.product.productPrice!, widget.product.productDiscountRate!.toDouble()).ceilToDouble() * _detailsController.productCount.value).toStringAsFixed(2)}",
                      style: context.appTheme.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                    );
                  },
                ),
                Obx(
                  () => Text(
                    "${_detailsController.productCount} items",
                    style: context.appTheme.textTheme.subtitle1!.copyWith(color: Colors.grey.shade700),
                  ),
                )
              ],
            ),
            Padding(
              padding: context.paddingOnlyRightLow,
              child: Obx(
                () {
                  return ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                    onPressed: _detailsController.isAddingToCard.value
                        ? () {}
                        : () {
                            if (widget.product.productId != null && (_userController.user.value != null)) {
                              _detailsController.addProductToCart(widget.product.productId!, 1, _userController.user.value!.email);
                            }
                          },
                    child: Container(
                      padding: context.paddingAllLow,
                      margin: context.paddingAllVeryLow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            _detailsController.isAddingToCard.value ? "Adding to Basket" : "Add to Basket",
                            style: context.appTheme.textTheme.subtitle1!.copyWith(color: Colors.white),
                          ),
                          Padding(
                            padding: context.paddingOnlyLeftLow,
                            child: _detailsController.isAddingToCard.value
                                ? SizedBox(
                                    width: 23,
                                    height: 23,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                  )
                                : Icon(MaterialCommunityIcons.basket),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
