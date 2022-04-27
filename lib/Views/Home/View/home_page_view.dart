import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:shopism/Controllers/home_page_controller.dart';
import 'package:shopism/Controllers/user_controller.dart';
import 'package:shopism/Core/Constants/Enums/getx_keys.dart';
import 'package:shopism/Core/Extensions/context_extensions.dart';
import 'package:shopism/Core/Utils/utils.dart';
import 'package:shopism/Views/AllProducts/View/all_products.dart';
import 'package:shopism/Views/Cart/View/cart_page_view.dart';
import 'package:shopism/Widgets/Home/popular_product_card.dart';

import '../../../Controllers/product_details_controller.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late PageController _pageController;
   HomePageController _homePageController = Get.put(HomePageController(), tag: GetxKeys.HOME_PAGE_CONTEROLLER.toString());
  UserController _userController =
      Get.find(tag: GetxKeys.USER_CONTROLLER.toString());
  Utils _utils = Utils.instance;


  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => ProductDetailsController(), tag: GetxKeys.PRODUCT_DETAILS_CONTROLLER.toString());
    _pageController = PageController(viewportFraction: 1, initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: PageStorageKey("key"),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildLocationRow(context),
            buildSearchBar(context),
            // Selected indexler gelecek,
            buildCategoriesRow(),
            buildCarouselPageView(),
            buildPopularProductsRow(context),
            buildPopularProducts(context),

          ],
        ),
      ),
    );
  }

  Container buildPopularProducts(BuildContext context) {
    return Container(
      height: 250,
      margin: context.paddingAllLow,
      child: Obx(() {
        if (_homePageController.productsLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) =>
                Padding(padding: EdgeInsets.only(left: 10)),
            itemCount: 10 < _homePageController.products.value.length
                ? 10
                : _homePageController.products.value.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return PopularProductCard(
                product: _homePageController.products.value[index],
              );
            },
          );
        }
      }),
    );
  }

  Padding buildPopularProductsRow(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: context.paddingOnlyBottomVeryLow,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "Popular Products",
                      style: context.theme.textTheme.headline6,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Fresh product from our garden",
                    style: context.theme.textTheme.subtitle1!
                        .copyWith(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AllProductsView(),));
              },
              child: Row(
                children: [
                  Text(
                    "See All",
                    style: context.theme.textTheme.subtitle2,
                  ),
                  Container(
                    padding: context.paddingAllVeryLow,
                    margin: context.paddingOnlyLeftLow,
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: Icon(
                      MaterialCommunityIcons.arrow_right,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget buildCarouselPageView() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              _homePageController.setPageViewIndex(index);
            },
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: 200,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 20,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Obx(
                () {
                  return Icon(
                    Entypo.dot_single,
                    color: _homePageController.pageViewIndex.value == index
                        ? Colors.red
                        : Colors.blue,
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildCategoriesRow() {
    return Container(
      height: 140,
      child: Obx(() => _homePageController.categoriesLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _homePageController.categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [BoxShadow(color: Colors.black)],
                                border:
                                    Border.all(color: Colors.white, width: 4),
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(_homePageController
                                        .categories[index].categoryImageUrl ??
                                    "https://erasmusnation-com.ams3.digitaloceanspaces.com/woocommerce-placeholder.png"),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: Text(
                                  '${_homePageController.categories[index].categoryName}'),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )),
    );
  }

  Padding buildSearchBar(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow,
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(Feather.search),
            hintText: 'Try "Tomatos"',
            fillColor: Color(0xffF1F4FA),
            filled: true,
            contentPadding: context.paddingVerticalLow,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(48),
                borderSide: BorderSide(width: 0, style: BorderStyle.none))),
      ),
    );
  }

  Widget buildLocationRow(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTopLow,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: context.paddingAllLow,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Delivery adress",
                      style: context.theme.textTheme.subtitle1!
                          .copyWith(color: Colors.grey.shade700)),
                  Padding(
                    padding: context.paddingOnlyTopVeryLow,
                    child: Text(
                      "${_utils.setAddressString(_userController.user.value)}",
                      style: context.theme.textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => CartPageView()));
            },
            icon: Icon(
              AntDesign.shoppingcart,
              color: Colors.grey.shade600,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.notifications_outline,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
