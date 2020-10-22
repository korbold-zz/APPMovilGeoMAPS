import 'package:busmart/features/register/data/datasources/data_remote.dart';
import 'package:busmart/features/register/domain/repositories/register_domain_respositoryINTERFACE.dart';

class RegisterDataRepositoryIMPL implements RegisterDomainRepositoryINTERFACE {
  final _registerDataRemote = RegisterDataRemote();

  @override
  Future<bool> postRegister(
      {String dni,
      String firstName,
      String lastName,
      String dateBirth,
      String numberCell,
      String userName,
      String password,
      String email}) async {
    return await _registerDataRemote.postRegister(
      dni: dni,
      firstName: firstName,
      lastName: lastName,
      dateBirth: dateBirth,
      numberCell: numberCell,
      userName: userName,
      password: password,
      email: email,
    );
  }
}
