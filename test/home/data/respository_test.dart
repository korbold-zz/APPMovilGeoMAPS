import 'package:busmart/features/home/data/datasources/api_home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('getRoutes', () {
    Future getRoutesEntities() async {
      var _uriResponse;
      final _cliente = http.Client();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': '*/*'
      };
      try {
        _uriResponse = await _cliente.get(
          apiHome,
          headers: headers,
        );

        print('Response status: ${_uriResponse.statusCode}');
        print('Response body: ${_uriResponse.body}');
        return _uriResponse;
      } catch (e) {
        print('E R R O R: $e');
      } finally {
        _cliente.close();
      }
      
      
    }

    expect(getRoutesEntities, isNotNull);
  });
}
