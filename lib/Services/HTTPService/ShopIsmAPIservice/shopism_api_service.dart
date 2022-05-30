import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:shopism/Models/Category/category_model.dart';
import 'package:shopism/Models/Delivery/delivery_model.dart';
import 'package:shopism/Models/Installment/installment_model.dart';
import 'package:shopism/Models/Product/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shopism/Models/User/account_model.dart';
import 'package:shopism/Models/User/login_model.dart';

import '../../../Models/Cart/cart_model.dart';
import '../../../Models/OrderModel/order_model.dart';

class ShopismAPIService {
  static ShopismAPIService _instance = ShopismAPIService._init();

  static ShopismAPIService get instance => _instance;

  ShopismAPIService._init();

  String _baseUrl = 'https://shopism.herokuapp.com';

  Future<List<Product>> getAllProducts() async {
    try {
      List<Product> products = [];
      Uri url = Uri.parse('${_baseUrl}/products');
      http.Response response = await http.get(url);

      if (response.statusCode != HttpStatus.ok) {
        return [];
      }

      dynamic body = jsonDecode(response.body);

      if (body.runtimeType == List<dynamic>) {
        List bodyList = body;
        bodyList.forEach((element) {
          Product product = Product.fromJson(element);
          products.add(product);
        });
      } else {
        return [];
      }
      return products;
    } catch (e) {
      print("[HATA] [ShopismAPIService] [getAllProduct] --> " + e.toString());
      return [];
    }
  }

  Future<bool> completeOrder(AccountModel accountModel, CartModel cartModel, int deliveryID, Installment installment) async {
    Uri url = Uri.parse('${_baseUrl}/order/create');

    try {
      http.Response response = await http.post(url, body: {
        'userEmail': accountModel.email.toString(),
        'orderAddress': accountModel.addressID.toString(),
        'cartItem': cartModel.cartItem.toString(),
        'deliveryId': deliveryID.toString(),
        'installment': installment.installment!.toString(),
        'installmentPrice': installment.installmentAmount!.toString(),
        'totalPrice': installment.totalPrice!.toString(),
        'paymentType': installment.paymentType.toString(),
      });
      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        print("false düştü : ${response.body}");
        return false;
      }
    } catch (e) {
      print("[HATA] [ShopismAPIService] [completeOrder] --> " + e.toString());
      return false;
    }
  }

  Future<List<Product>> getCategoryItems(CategoryModel categoryModel) async {
    try {
      List<Product> products = [];
      Uri url = Uri.parse('${_baseUrl}/products/category/${categoryModel.categoryID}');
      http.Response response = await http.get(url);

      if (response.statusCode != HttpStatus.ok) {
        return [];
      }

      dynamic body = jsonDecode(response.body);

      if (body.runtimeType == List<dynamic>) {
        List bodyList = body;
        bodyList.forEach((element) {
          Product product = Product.fromJson(element);
          product.category = ProductCategory(id: categoryModel.categoryID, name: categoryModel.categoryName);
          products.add(product);
        });
      } else {
        return [];
      }
      return products;
    } catch (e) {
      print("[HATA] [ShopismAPIService] [getCategoryItems] --> " + e.toString());
      return [];
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      Uri url = Uri.parse('${_baseUrl}/categories');

      http.Response response = await http.get(url);

      if (response.statusCode != HttpStatus.ok) return [];

      var body = jsonDecode(response.body);
      if (body.runtimeType != List<dynamic>) return [];

      List<CategoryModel> _categories = [];

      for (int i = 0; i < body.length; i++) {
        CategoryModel _categoryModel = CategoryModel.fromJSON(body[i]);
        _categories.add(_categoryModel);
      }

      print("Categories : ${_categories}");
      return _categories;
    } catch (e) {
      print("[HATA] [ShopismAPIService] [getAllCategories] --> " + e.toString());
      return [];
    }
  }

  Future<bool> signup(AccountModel userModel) async {
    try {
      Uri url = Uri.parse("${_baseUrl}/user/signup");
      http.Response response = await http.post(url, body: userModel.toJson());

      print(response.body);
      if (response.statusCode != HttpStatus.ok) return false;

      return true;
    } catch (e) {
      print("[HATA] [ShopismAPIService] [signup] --> " + e.toString());
      return false;
    }
  }

  Future<AccountModel?> login(LoginModel userModel) async {
    try {
      Uri url = Uri.parse("${_baseUrl}/user");
      http.Response response = await http.post(url, body: userModel.toJson());

      if (response.statusCode == HttpStatus.ok) {
        return AccountModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print("[HATA] [ShopismAPIService] [login] --> " + e.toString());
    }
  }

  Future<bool> addProductToCart(int productID, int count, String email) async {
    Uri url = Uri.parse("${_baseUrl}/cart/add");

    try {
      http.Response response = await http.post(
        url,
        body: {
          "email": email,
          "productId": productID.toString(),
          "quantity": count.toString(),
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        print("ürün eklendi addproduct +${response.body}");
        return true;
      } else {
        print("ürün eklenemedi addproduct ${response.body}");
        return false;
      }
    } catch (err) {
      print("[HATA] [ShopismAPIService] [addProductToCart] --> " + err.toString());
      return false;
    }
  }

  Future<List<CartModel>?> getCartItems(String email) async {
    Uri uri = Uri.parse("${_baseUrl}/cart/mycart");
    List<CartModel> _cartItems = [];
    try {
      http.Response response = await http.post(uri, body: {"email": email});
      if (response.statusCode != HttpStatus.ok) return null;

      var body = jsonDecode(response.body);

      if (body.runtimeType != List<dynamic>) return null;

      (body as List<dynamic>).forEach((element) {
        CartModel _product = CartModel.fromJSON(element);
        if (!_cartItems.any((element) => element.productId == _product.productId)) {
          _cartItems.add(_product);
        } else {
          CartModel foundedProduct = _cartItems.firstWhere((element) => element.productId == _product.productId);

          if (foundedProduct.quantity != null && _product.quantity != null) {
            foundedProduct.quantity = (foundedProduct.quantity! + _product.quantity!);
          }

          _cartItems[_cartItems.indexWhere((element) => element.productId == _product.productId)] = foundedProduct;
        }
      });
      _cartItems.forEach((element) {
        if (element.quantity != null && element.price != null) {
          element.price = (element.price! * element.quantity!);
        }
      });

      print("cartitems length : ${_cartItems.length}");

      return _cartItems;
    } catch (err) {
      print("[HATA] [ShopismAPIService] [getCartItems] --> " + err.toString());
      return null;
    }
  }

  Future<bool> removeItemFromCart(int id) async {
    Uri uri = Uri.parse("${_baseUrl}/cart/remove");
    try {
      http.Response response = await http.post(uri, body: {
        "cartItemId": "${id}",
      });
      if (response.statusCode != HttpStatus.ok) return false;
      print("ürün kaldırıldıdsa");
      return true;
    } catch (err) {
      print("[HATA] [ShopismAPIService] [removeItemFromCart] --> " + err.toString());
      return false;
    }
  }

  Future<List<DeliveryModel>?> getDeliveries() async {
    Uri uri = Uri.parse("${_baseUrl}/delivery");

    try {
      http.Response response = await http.get(uri);
      if (response.statusCode != HttpStatus.ok) return null;
      List<DeliveryModel> deliveries = [];

      var responseMap = jsonDecode(response.body);

      if (responseMap.runtimeType != List<dynamic>) return null;

      for (int i = 0; i < responseMap.length; i++) {
        deliveries.add(DeliveryModel.fromJSON(responseMap[i]));
      }
      return deliveries;
    } catch (err) {
      print("[HATA] [ShopismAPIService] [getDeliveries] --> " + err.toString());
      return null;
    }
  }

  // Get my orders from URL=https://shopism.herokuapp.com/order/me
  Future<List<OrderModel>?> getMyOrders(String email) async {
    Uri uri = Uri.parse("${_baseUrl}/order/me");
    List<OrderModel> _orders = [];
    try {
      http.Response response = await http.post(uri, body: {"email": email});
      if (response.statusCode != HttpStatus.ok) return null;

      var body = jsonDecode(response.body);

      if (body.runtimeType != List<dynamic>) return null;

      (body as List<dynamic>).forEach((element) {
        OrderModel _order = OrderModel.fromJson(element);
        _orders.add(_order);
      });

      return _orders;
    } catch (err) {
      print("[HATA] [ShopismAPIService] [getMyOrders] --> " + err.toString());
      return null;
    }
  }
}
