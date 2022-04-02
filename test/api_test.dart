import 'package:shopism/Models/Product/product_model.dart';
import 'package:shopism/Services/HTTPService/ShopIsmAPIservice/shopism_api_service.dart';
import 'package:test/test.dart';

void main(){
  group("ShopismAPIService Test", (){


    ShopismAPIService apiService = ShopismAPIService.instance;

    test("GetAllProducts Test", () async{
      List<Product> products =  await apiService.getAllProducts();

      print("Products Length : ${products.length}");
      expect(products.isNotEmpty, true);


    });


  });

}