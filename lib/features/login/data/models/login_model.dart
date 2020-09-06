import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.idToken,
    this.credentials,
  });

  String idToken;
  Credentials credentials;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        idToken: json["id_token"],
        credentials: Credentials.fromJson(json["credentials"]),
      );

  Map<String, dynamic> toJson() => {
        "id_token": idToken,
        "credentials": credentials.toJson(),
      };
}

class Credentials {
  Credentials({
    this.authorities,
    this.details,
    this.authenticated,
    this.principal,
    this.credentials,
    this.name,
  });

  List<dynamic> authorities;
  dynamic details;
  bool authenticated;
  String principal;
  String credentials;
  String name;

  factory Credentials.fromJson(Map<String, dynamic> json) => Credentials(
        authorities: List<dynamic>.from(json["authorities"].map((x) => x)),
        details: json["details"],
        authenticated: json["authenticated"],
        principal: json["principal"],
        credentials: json["credentials"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "authorities": List<dynamic>.from(authorities.map((x) => x)),
        "details": details,
        "authenticated": authenticated,
        "principal": principal,
        "credentials": credentials,
        "name": name,
      };
}
