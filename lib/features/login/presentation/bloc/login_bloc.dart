//export BLoc with provider package

import 'package:busmart/features/login/data/models/login_model.dart';
import 'package:busmart/features/login/data/repositories/login_data_repositoy.dart';

class LoginBloc {
  LoginModel _loginModel;
  final _loginDataRepository = LoginDataRepository();

  void sendSession(String user, String password) async {
    _loginModel = await _loginDataRepository.postLogin(user, password);
    print(_loginModel);
  }
}
