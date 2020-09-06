import 'package:busmart/features/login/data/datasources/api_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

var client = http.Client();
var uriResponse;
void main() {

  group('login',() {


    var client = http.Client();
    var uriResponse;
    try {
      uriResponse =  client
          .post(apiLogin, body: {"username": 'admin', "password": 'admin'});

      print('Response status: ${uriResponse.statusCode}');
      print('Response body: ${uriResponse.body}');
    } catch (e) {
      print(e.toString());
    } finally {
      client.close();
    }
    test('Login post', () {
      //take
      expect(uriResponse, isNotNull,);
    });
  });
  
}