import 'package:shopism/Core/Extensions/string_extensions.dart';
import 'package:shopism/Models/Product/product_model.dart';
import 'package:shopism/Models/User/account_model.dart';

class Utils {
  Utils._init();

  static Utils? _instance;

  static Utils get instance {
    _instance ??= Utils._init();
    return _instance!;
  }
  static String creditCart = "Kredi Kartı";
  static String havale = "Havale/EFT";
  double calculateDiscountedPrice(double price, double discountRate) {
    return price - ((price * (discountRate * 100)) / 100);
  }

  String setAddressString(AccountModel? accountModel) {
    if (accountModel == null) return "-";
    return "${accountModel.city} " + "${accountModel.country} " + "${accountModel.district} " + "${accountModel.addressFirst} ";
  }

  String setUserNameString(AccountModel? accountModel) {
    if (accountModel == null) return "-";

    return "${accountModel.name.capitalize} " + "${accountModel.surname.capitalize} ";
  }
}
