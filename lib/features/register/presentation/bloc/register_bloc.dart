import 'package:busmart/features/register/domain/repositories/register_domain_respositoryINTERFACE.dart';
import 'package:flutter/material.dart';

class RegistrerBloc with ChangeNotifier {
  final RegisterDomainRepositoryINTERFACE _register;
  bool _resultRegister;
  RegistrerBloc(this._register);

  Future<bool> sendRegisterData({
    String dni,
    String firstName,
    String lastName,
    String dateBirth,
    String numberCell,
    String userName,
    String password,
    String email,
  }) async {
    final resp = await _register.postRegister(
        dateBirth: dateBirth,
        dni: dni,
        email: email,
        firstName: firstName,
        lastName: lastName,
        numberCell: numberCell,
        password: password,
        userName: userName);

    return resp;
    
  }

  get getResultRegister => _resultRegister;
}
