import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeDataLocal {
  Future<String> loadToken();
  Future<String> loadUser();
  Future<String> loadPassword();
  
}

class HomeDataLocalImplementation implements HomeDataLocal {
  SharedPreferences _preferences;

  final _flutterSecureStorage = new FlutterSecureStorage();
  final String _userKey = 'user';
  final String _passwordKey = 'password';

  @override
  Future<String> loadToken() async {
    return await _flutterSecureStorage.read(key: 'jwt');
  }

  @override
  Future<String> loadPassword() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getString(_userKey);
  }

  @override
  Future<String> loadUser() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.getString(_passwordKey);
  }
}
