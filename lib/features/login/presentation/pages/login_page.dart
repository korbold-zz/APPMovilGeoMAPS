import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _bloc = LoginBloc();
  final _userControler = TextEditingController(text: '');
  final _passwordControler = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlutterLogo(
                  size: 80,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Usuario'),
                  controller: _userControler,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo Obligatorio';
                    } else
                      return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  controller: _passwordControler,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo Obligatorio';
                    } else
                      return null;
                  },
                ),
                RaisedButton(
                  onPressed: ()  {
                    if (_formKey.currentState.validate()) {
                       _bloc.sendSession(
                          _userControler.text, _passwordControler.text);
                    }
                  },
                  child: Text('Iniciar Sesión'),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Registrar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
