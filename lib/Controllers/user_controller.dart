import 'package:get/get.dart';
import 'package:shopism/Core/Constants/Enums/preferences_keys.dart';
import 'package:shopism/Core/Init/Cache/user_cache_manager.dart';
import 'package:shopism/Models/User/account_model.dart';
import 'package:shopism/Models/User/login_model.dart';
import 'package:shopism/Services/HTTPService/ShopIsmAPIservice/shopism_api_service.dart';

//Signup ve login için controller ayıracaktım ama uğraşmadım
class UserController extends GetxController {
  ShopismAPIService _apiService = ShopismAPIService.instance;
  UserCacheManager _userCacheManager = UserCacheManager.instance;

  // islogging -> Uygulama ilk açıldığında splash screene mi yoksa home screene mi atacağımızı belirleyen variable.
  var isLogging = false.obs;

  RxBool isLoginPasswordHidden = true.obs;
  RxBool isSignupPasswordHidden = true.obs;
  RxBool isSignupLoading = false.obs;
  RxBool isLoginLoading = false.obs;
  RxBool isLogoutLoading = false.obs;
  Rxn<AccountModel?> user = Rxn();

  void toggleLoginPasswordHidden() => isLoginPasswordHidden.value = !isLoginPasswordHidden.value;
  void toggleSignupPasswordHidden() => isSignupPasswordHidden.value = !isSignupPasswordHidden.value;

  Future<bool> login(LoginModel loginModel) async {
    isLoginLoading.value = true;

    try {
      AccountModel? accountModel = await _apiService.login(loginModel);
      if (accountModel != null) {
        //add user to cache
        await _userCacheManager.putItem(HiveKeys.USER_INFO, accountModel);
        user.value = accountModel;
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print("login error  : ${err.toString()}");
      return false;
    } finally {
      isLoginLoading.value = false;
    }

    // return isLogged;
  }

  Future<bool> signup(AccountModel userModel) async {
    isSignupLoading.value = true;
    bool isLogged = await _apiService.signup(userModel);
    isSignupLoading.value = false;
    return isLogged;
    //Giriş yap ekranına yönlendir
  }

  Future<void> getUserFromCache() async {
    isLogging.value = true;
    //some cache methods if(value != null) isLogged = true; user.value = value;
    try {
      var _user = await _userCacheManager.getItem(HiveKeys.USER_INFO);
      if (_user != null) {
        user.value = _user;
      }
    } catch (err) {
      print("getuserfromcache error");
    } finally {
      isLogging.value = false;
    }
  }

  Future<void> signOut() async {
    isLogoutLoading.value = true;
    try {
      await _userCacheManager.deleteItem(HiveKeys.USER_INFO);
      user.value = null;
      // user = Rxn<AccountModel?>();
    } catch (err) {
      print("signout error");
    } finally {
      isLogoutLoading.value = false;
    }
  }
}
