
import 'package:busmart/features/login/data/models/login_model.dart';

abstract class LoginDomainRepositoryINTERFACE {
  Future<LoginModel> postLogin(String user, String password);
  Future<bool> postPasswordReset(String email);
  Future<bool> verifySessionInCache();
  Future<bool> clearCredentials();
  
}
