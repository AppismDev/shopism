import 'package:hive/hive.dart';
import 'package:shopism/Core/Constants/Enums/preferences_keys.dart';

part 'account_model.g.dart';

@HiveType(typeId: HiveConstants.accountTypeID)
class AccountModel {
  @HiveField(0)
  String email;
  @HiveField(1)
  String password;
  @HiveField(2)
  String name;
  @HiveField(3)
  String surname;
  @HiveField(4)
  String? phone;
  @HiveField(5)
  String? tcno;
  @HiveField(6)
  int? addressID;
  @HiveField(7)
  String? country;
  @HiveField(8)
  String? city;
  @HiveField(9)
  String? district;
  @HiveField(10)
  String? addressFirst;
  @HiveField(11)
  String? adrressSecond;

  AccountModel(
      {required this.email,
      required this.password,
      required this.name,
      required this.surname,
      this.phone,
      this.tcno,
      this.addressFirst,
      this.addressID,
      this.adrressSecond,
      this.city,
      this.country,
      this.district});

  factory AccountModel.fromJson(Map<String, dynamic> map) {
    return AccountModel(
      name: map["name"],
      surname: map["surname"],
      email: map["email"],
      password: map["password"],
      phone: map["phone"] ?? "",
      tcno: map["tcno"] ?? "",
      addressFirst: map["address_first"] ?? "",
      addressID: map["address_id"] ?? "",
      adrressSecond: map["address_second"] ?? "",
      city: map["city"] ?? "",
      country: map["country"] ?? "",
      district: map["district"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "surname": surname,
      "email": email,
      "password": password,
      "phone": phone,
      "tcno": tcno,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return "${this.name}, ${this.email}";
  }
}
