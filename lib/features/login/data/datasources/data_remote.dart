import 'dart:convert';

import 'package:busmart/features/login/data/datasources/api_login.dart';
import 'package:busmart/features/login/data/models/login_model.dart';
import 'package:http/http.dart' as http;

abstract class DataRemote {
  Future<LoginModel> postLogin(String user, String password);
  Future<bool> postPasswordReset(String email);
}

class DataRemoteImpl implements DataRemote {
  @override
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
          body: jsonEncode(
              {'password': password, "rememberMe": true, 'username': user}));

      print('Response status: ${_uriResponse.statusCode}');
      print('Response body: ${_uriResponse.body}');
    } catch (e) {
      print('E R R O R: $e');
    } finally {
      _cliente.close();
    }
    if (_uriResponse.statusCode == 200) {
      
      return loginModelFromJson(_uriResponse.body);
    } else {
      return null;
    }
  }

  @override
  Future<bool> postPasswordReset(String email) async {
    var _uriResponse;
    final _cliente = http.Client();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': '*/*'
    };
    try {
      _uriResponse = await _cliente.post(apirequestPasswordReset,
          headers: headers, body: (email));

      print('Response status: ${_uriResponse.statusCode}');
      print('Response body: ${_uriResponse.body}');
    } catch (e) {
      print('E R R O R: $e');
    } finally {
      _cliente.close();
    }
    if (_uriResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
