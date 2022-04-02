import 'dart:convert';
import 'dart:io';

import 'package:shopism/Models/Product/product_model.dart';
import 'package:http/http.dart' as http;

class ShopismAPIService {

  static ShopismAPIService _instance = ShopismAPIService._init();
  static ShopismAPIService get instance => _instance;
  ShopismAPIService._init();
  
  String _baseUrl = 'https://shopism.herokuapp.com';


  Future<List<Product>> getAllProducts() async{
    try {
      List<Product> products = [];
      Uri url = Uri.parse('${_baseUrl}/products');
      http.Response response = await http.get(url);

      if(response.statusCode != HttpStatus.ok){
        return [];
      }

      dynamic body = jsonDecode(response.body);

      if(body.runtimeType == List<dynamic>){
        List bodyList = body;
        bodyList.forEach((element) {
          Product product = Product.fromJson(element);
          products.add(product);
        });
      }else{
        return [];
      }
      return products;
    } catch (e) {
      print("[HATA] [ShopismAPIService] [getAllProduct] --> " + e.toString());
      return [];
    }
  }



}
