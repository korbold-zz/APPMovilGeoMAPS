

import 'package:busmart/features/login/data/models/login_model.dart';
import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('Sessions', (){
    LoginBloc _loginBloc;
    LoginModel _model;

    Future <bool> post() async{
        return  await _loginBloc.sendSession(password: 'get\$321', user: 'korbold');
    }

    test('Save', (){
      expect(post, isNotNull );

    });
  });
}