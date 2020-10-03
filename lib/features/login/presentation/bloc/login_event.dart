import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';



class LoginEvent with ChangeNotifier {
  bool _visibilityPassword = true;
  

  LoginBloc user;

  set setVisibilityPassword(bool value) {
    _visibilityPassword = value;
    notifyListeners();
  }

 

  bool get getVisibilityPassword => _visibilityPassword;
  
}
