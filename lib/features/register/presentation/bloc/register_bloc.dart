import 'package:busmart/features/register/data/repositories/register_data_repository.dart';
import 'package:flutter/material.dart';

class RegistrerBloc with ChangeNotifier {
  final _register = RegisterDataRepository();

  sendRegisterData({
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
}
