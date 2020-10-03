import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DataLocal {
  Future<void> saveCredentials(String token, String user, String password);
  Future<String> loadToken();
  Future<String> loadUser();
  Future<String> loadPassword();
  Future<bool> verifyUserCredential();
  bool clearCredentials();
}

class DataLocalImplementation implements DataLocal {
  SharedPreferences _preferences;

  final _flutterSecureStorage = new FlutterSecureStorage();
  final String _userKey = 'user';
  final String _passwordKey = 'password';

  @override
  Future<String> loadToken() async {
    return await _flutterSecureStorage.read(key: 'jwt');
  }

  @override
  Future<void> saveCredentials(
      String token, String user, String password) async {
    try {
      _preferences = await SharedPreferences.getInstance();
      _preferences.setString(_userKey, user);
      _preferences.setString(_passwordKey, password);
      _flutterSecureStorage.write(key: 'jwt', value: token);
    } catch (e) {
      print('ERROR saveCredentials $e');
    }
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

  @override
  bool clearCredentials() {
    _preferences.clear();
    _flutterSecureStorage.delete(key: 'jwt');
    return true;
  }

  @override
  Future<bool> verifyUserCredential() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences.containsKey(_userKey);
  }
}
