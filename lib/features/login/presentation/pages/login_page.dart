import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _scaffolKey = GlobalKey<ScaffoldState>();

  final _userControler = TextEditingController(text: '');

  final _passwordControler = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final _bloc =
        // LoginBloc();
        Provider.of<LoginBloc>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        key: _scaffolKey,
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
                _bloc.status == Status.Authenticating
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            if (!await _bloc.sendSession(
                                user: _userControler.text,
                                password: _passwordControler.text)) {
                              _scaffolKey.currentState.showSnackBar(SnackBar(
                                content:
                                    Text("Usuario y Contraseña no existe."),
                              ));
                            }
                          }
                        },
                        child: Text('Iniciar Sesión'),
                      ),
                GestureDetector(
                  child: Container(
                    color: Colors.amberAccent,
                    height: 25,
                    child: Text(
                      '¿Olvido la Contraseña?',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/PasswordResetPage');
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/RegisterPage');
                  },
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
