import 'package:busmart/features/login/domain/repositories/login_domain_repository.dart';

import 'package:flutter/material.dart';

enum Status {
  Uninitialized,
  Authenticating,
  Unauthenticated,
  Authenticated,
}

class LoginBloc with ChangeNotifier {
  // final loginDataRepository = LoginDataRepositoryImpl();
  final LoginDomainRepositoryINTERFACE loginDataRepository;
  Status _status = Status.Uninitialized;
  bool _isLoginIn = false;

  LoginBloc(this.loginDataRepository) {
    verifyCredentials();
  }

  set setIsLogin(bool value) {
    _isLoginIn = value;
    notifyListeners();
  }

  set setStatusLogin(Status value1) {
    _status = value1;
    notifyListeners();
  }

  Status get status => _status;
  bool get isLogin => _isLoginIn;

  Future<bool> sendSession({String user, String password}) async {
    _status = Status.Authenticating;

    final _loginModel = await loginDataRepository.postLogin(user, password);
    if (_loginModel != null) {
      _status = Status.Authenticated;
      _isLoginIn = true;
      notifyListeners();
      return true;
    } else {
      _status = Status.Unauthenticated;
      _isLoginIn = true;
      notifyListeners();
      return false;
    }
  }

 Future<bool> verifyCredentials() async {
    final responseSessionCache =
        await loginDataRepository.verifySessionInCache();
    if (responseSessionCache) {
      _status = Status.Authenticated;
      _isLoginIn = true;
      notifyListeners();
      return true;
    } else {
      _status = Status.Unauthenticated;
      _isLoginIn = false;

      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _status = Status.Unauthenticated;
    final result =loginDataRepository.clearCredentials();
    _isLoginIn = true;
    notifyListeners();
    return result ;
  }

  /* ------------------postPasswordReset---------------------------------- */

  sendPasswordReset({String email}) async {
    final resp = await loginDataRepository.postPasswordReset(email);
    if (resp) {
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }
}
