import 'dart:convert';

import 'package:busmart/features/login/data/datasources/api_login.dart';
import 'package:busmart/features/login/data/models/login_model.dart';
import 'package:http/http.dart' as http;

class LoginDataRepository {
  Future<LoginModel> postLogin(String user, String password) async {
    var _uriResponse;
    final _cliente = http.Client();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': '*/*'
    };
    try {
      _uriResponse = await _cliente.post(apiLogin,
          headers: headers,
          body: jsonEncode({'password': password, 'username': user}));

      print('Response status: ${_uriResponse.statusCode}');
      print('Response body: ${_uriResponse.body}');
    } catch (e) {} finally {
      _cliente.close();
    }
    return loginModelFromJson(_uriResponse.body);
  }
}
