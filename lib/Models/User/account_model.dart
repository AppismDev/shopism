class AccountModel {
  String? email;
  String? password;
  String? name;
  String? surname;
  String? phone;
  String? tcno;

  AccountModel.empty();
  AccountModel(
      {required this.email,
      required this.password,
      required this.name,
      required this.surname,
      this.phone,
      this.tcno});

  factory AccountModel.fromJson(Map<String, dynamic> map) {
    return AccountModel(
      name: map["name"],
      surname: map["surname"],
      email: map["email"],
      password: map["password"],
      phone: map["phone"] ?? "",
      tcno: map["tcno"] ?? "",
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
}
