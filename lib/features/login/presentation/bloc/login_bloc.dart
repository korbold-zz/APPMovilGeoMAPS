//export BLoc with provider package

import 'package:busmart/features/login/data/models/login_model.dart';
import 'package:busmart/features/login/data/repositories/login_data_repositoy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  Uninitialized,
  Authenticating,
  Unauthenticated,
  Authenticated,
}

class LoginBloc with ChangeNotifier {
  final _loginDataRepository = LoginDataRepository();
  final _storage = FlutterSecureStorage();
  LoginModel _loginModel;
  SharedPreferences _preferences;
  Status _status = Status.Uninitialized;
  bool _isLoginIn = false;

  LoginBloc.instance() {
    verifyCredentials();
  }

  Future<bool> sendSession({String user, String password}) async {
    setStatusLogin = Status.Authenticating;
    notifyListeners();
    _loginModel = await _loginDataRepository.postLogin(user, password);
    if (_loginModel != null) {
      setStatusLogin = Status.Authenticated;
      _isLoginIn = true;
      _storage.write(key: 'jwt', value: _loginModel.idToken);
      // _preferences.setString('idToken', _loginModel.idToken);
      _preferences.setString('name', _loginModel.credentials.name);
      jwtDecode();
      notifyListeners();
      return true;
    } else {
      setStatusLogin = Status.Unauthenticated;
      _isLoginIn = true;
      notifyListeners();
      return false;
    }
  }

  verifyCredentials() async {
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.containsKey('name')) {
      setStatusLogin = Status.Authenticated;
      _isLoginIn = true;
      notifyListeners();
    } else {
      setStatusLogin = Status.Unauthenticated;
      _isLoginIn = false;
      notifyListeners();
    }
  }

  Future signOut() async {
    setStatusLogin = Status.Unauthenticated;
    _preferences.clear();
    _storage.delete(key: 'jwt');
    _isLoginIn = true;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Status get status => _status;
  bool get isLogin => _isLoginIn;

  set setIsLogin(bool value) {
    _isLoginIn = value;
    notifyListeners();
  }

  set setStatusLogin(Status value) {
    _status = value;
    notifyListeners();
  }

  jwtDecode() async {
    final token = await _storage.read(key: 'jwt');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print(decodedToken["sub"]);
    bool isTokenExpired = JwtDecoder.isExpired(token);
    print(isTokenExpired);
  }

  /* ------------------postPasswordReset---------------------------------- */

  sendPasswordReset({String email}) async {
    final resp = await _loginDataRepository.postPasswordReset(email);
    if (resp) {
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }
}
