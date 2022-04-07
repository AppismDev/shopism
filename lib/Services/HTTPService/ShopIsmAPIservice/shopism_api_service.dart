import 'dart:convert';
import 'dart:io';

import 'package:shopism/Models/Category/category_model.dart';
import 'package:shopism/Models/Product/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shopism/Models/User/account_model.dart';

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
      print(
          "[HATA] [ShopismAPIService] [getAllCategories] --> " + e.toString());
      return [];
    }
  }

  Future<bool> signup(AccountModel userModel) async {
    try {
      Uri url = Uri.parse("${_baseUrl}/user/signup");
      http.Response response = await http.post(url, body: userModel.toJson());

      if (response.statusCode != HttpStatus.ok) return false;

      return true;
    } catch (e) {
      print("[HATA] [ShopismAPIService] [signup] --> " + e.toString());
      return false;
    }
  }
}
