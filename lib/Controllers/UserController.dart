import 'package:get/get.dart';
import 'package:shopism/Models/User/account_model.dart';
import 'package:shopism/Services/HTTPService/ShopIsmAPIservice/shopism_api_service.dart';

class UserController extends GetxController {
  ShopismAPIService _apiService = ShopismAPIService.instance;
  var isLogged = false.obs;
  // islogging -> Uygulama ilk açıldığında splash screene mi yoksa home screene mi atacağımızı belirleyen variable.
  var isLogging = false.obs;
  var user = AccountModel.empty().obs;

  void login() {}

  Future<void> signup(AccountModel userModel) async {
    isLogged.value = await _apiService.signup(userModel);
    //Giriş yap ekranına yönlendir
  }

  Future<void> getUserFromCache() async {
    isLogging.value = true;
    //some cache methods if(value != null) isLogged = true; user.value = value;
    isLogging.value = false;
  }
}
