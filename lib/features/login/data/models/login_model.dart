import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.password,
    this.rememberMe,
    this.username,
  });

  String password;
  bool rememberMe;
  String username;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        password: json["password"],
        rememberMe: json["rememberMe"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "rememberMe": rememberMe,
        "username": username,
      };
}
