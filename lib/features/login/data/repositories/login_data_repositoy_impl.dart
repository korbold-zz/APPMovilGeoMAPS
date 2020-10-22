import 'package:busmart/features/login/data/datasources/data_local.dart';
import 'package:busmart/features/login/data/datasources/data_remote.dart';
import 'package:busmart/features/login/data/models/login_model.dart';
import 'package:busmart/features/login/domain/repositories/login_domain_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginDataRepositoryImpl implements LoginDomainRepositoryINTERFACE {
  final _dataRemoteApi = DataRemoteImpl();
  final _dataLocal = DataLocalImplementation();

  @override
  Future<LoginModel> postLogin(String user, String password) async {
    final responseDataRemote = await _dataRemoteApi.postLogin(user, password);
    if (responseDataRemote != null) {
      _dataLocal.saveCredentials(responseDataRemote.idToken, user, password);
    }
    return responseDataRemote;
  }

  @override
  Future<bool> postPasswordReset(String email) async {
    return await _dataRemoteApi.postPasswordReset(email);
  }

  @override
  Future<bool> verifySessionInCache() async {
    /* Verifica si la sesión esta en cache de la app y 
    el token no ha caducado */
    final responseUser = await _dataLocal.verifyUserCredential();
    if (responseUser) {
      final responseToken = await _dataLocal.loadToken();
      bool isTokenExpired = JwtDecoder.isExpired(responseToken);
      Map<String, dynamic> decodedToken = JwtDecoder.decode(responseToken);
      print(decodedToken["sub"]);

      if (isTokenExpired) {
        String _userLocal = await _dataLocal.loadUser();
        String _passwordLocal = await _dataLocal.loadUser();
        LoginModel _loginModel =
            await _dataRemoteApi.postLogin(_userLocal, _passwordLocal);
        _dataLocal.saveCredentials(
            _loginModel.idToken, _userLocal, _passwordLocal);
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> clearCredentials() async {
    return _dataLocal.clearCredentials();
  }
}
