import 'package:flutter/cupertino.dart';
import 'package:shopism/Views/Cart/View/cart_page_view.dart';
import 'package:shopism/Views/Home/View/home_page_view.dart';
import 'package:shopism/Views/OrderDetails/order_details.dart';
import 'package:shopism/Views/Tab/View/tab_page_view.dart';

enum PageKeys {
  HOME_PAGE,
  Tab_PAGE,
  CART_PAGE,
  ORDER_DETAILS_PAGE,
  PRODUCT_DETAILS_PAGE,
  CATEGORY_PAGE,
}

class Pages {
  static Map<String, Widget Function(BuildContext)> pages = {
    //TAB PAGE
    PageKeys.Tab_PAGE.toString(): (BuildContext context) => TabPageView(),
    PageKeys.HOME_PAGE.toString(): (_) => HomePageView(),
    PageKeys.CART_PAGE.toString(): (_) => CartPageView(),
    PageKeys.ORDER_DETAILS_PAGE.toString(): (_) => OrderDetails(),
  };
}
