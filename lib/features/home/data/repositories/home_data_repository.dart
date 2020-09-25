import 'package:busmart/features/home/data/datasources/api_home.dart';
import 'package:busmart/features/home/data/models/json_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class HomeDataRepository {
  final _storage = FlutterSecureStorage();
  Future<List<RutasModel>> getRoutesEntities() async {
    var _uriResponse;
    final token = await _storage.read(key: 'jwt');
    final _cliente = http.Client();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': '*/*',
      'Authorization': 'Bearer $token',
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
      return rutasModelFromJson(_uriResponse.body);
    } else {
      return null;
    }
    
  }
}
