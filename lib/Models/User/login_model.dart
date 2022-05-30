class LoginModel {
  String? email;
  String? password;

  LoginModel(
      {required this.email,
        required this.password,
      });

  factory LoginModel.fromJson(Map<String, dynamic> map) {
    return LoginModel(
      email: map["email"],
      password: map["password"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
