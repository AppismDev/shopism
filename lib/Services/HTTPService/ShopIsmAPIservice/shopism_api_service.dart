import 'dart:convert';
import 'dart:io';

import 'package:shopism/Models/Category/category_model.dart';
import 'package:shopism/Models/Product/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shopism/Models/User/account_model.dart';
import 'package:shopism/Models/User/login_model.dart';

import '../../../Models/Cart/cart_model.dart';

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
        }
      });

      return _cartItems;
    } catch (err) {
      print("[HATA] [ShopismAPIService] [getCartItems] --> " + err.toString());
      return null;
    }
  }
}
