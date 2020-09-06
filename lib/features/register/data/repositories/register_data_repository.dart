import 'dart:convert';

import 'package:busmart/features/register/data/datasources/api_register.dart';
import 'package:http/http.dart' as http;

class RegisterDataRepository {
  Future<bool> postRegister(
     { String dni,
      String firstName,
      String lastName,
      String dateBirth,
      String numberCell,
      String userName,
      String password,
      String email}) async {
    var _uriResponse;
    final _cliente = http.Client();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': '*/*'
    };
    try {
      _uriResponse = await _cliente.post(apiRegister,
          headers: headers,
          body: jsonEncode({
            "dayOfBirth": dateBirth,
            "dni": dni,
            "email": email,
            "firstName": firstName,
            "lastName": lastName,
            "login": userName,
            "password": password,
            "phone": numberCell
          }));

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
