import 'package:busmart/features/home/data/datasources/api_home.dart';
import 'package:http/http.dart' as http;

class HomeDataRepository {
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
    } catch (e) {
      print('E R R O R: $e');
    } finally {
      _cliente.close();
    }
    if (_uriResponse.statusCode == 200) {
      return null;
    } else {
      return null;
    }
  }
}
