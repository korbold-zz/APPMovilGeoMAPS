import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:busmart/features/login/presentation/bloc/login_event.dart';
import 'package:busmart/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    
    final _bloc = Provider.of<LoginBloc>(context);
    final _event = Provider.of<LoginEvent>(context);
    
    
    return SafeArea(
      child: Scaffold(
        key: _scaffolKey,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SvgPicture.asset(
                    //   'assets/svg/logoBlue.svg',
                    //   height: 80,
                    //   width: 80,
                    // ),
                    Image.asset('assets/img/logoBlue.png'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 70,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Usuario',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        controller: _userControler,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo Obligatorio';
                          } else
                            return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 70,
                      child: Stack(
                        children: [
                          TextFormField(
                            cursorColor: colorPrimary,
                            obscureText: _event.getVisibilityPassword,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            controller: _passwordControler,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Campo Obligatorio';
                              } else
                                return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: FlatButton(
                                onPressed: () {
                                  _event.getVisibilityPassword
                                      ? _event.setVisibilityPassword = false
                                      : _event.setVisibilityPassword = true;
                                },
                                child: Icon(
                                  _event.getVisibilityPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: colorPrimary,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      child: Container(
                        height: 25,
                        child: Text(
                          '¿Olvido la Contraseña?',
                          style: TextStyle(fontSize: 15, color: colorPrimary),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/PasswordResetPage');
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _bloc.status == Status.Authenticating
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            color: colorPrimary,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                if (!await _bloc.sendSession(
                                    user: _userControler.text,
                                    password: _passwordControler.text)) {
                                  _scaffolKey.currentState.showSnackBar(SnackBar(
                                    content: Text(
                                      "Usuario y Contraseña no existe.",
                                    ),
                                  ));
                                }
                              }
                            },
                            child: Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      color: Colors.white,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/facebook.png',
                            height: 25,
                            width: 25,
                          ),
                          Text(
                            '  Iniciar Sesión con Facebook',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      color: Colors.white,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/google.png',
                            height: 25,
                            width: 25,
                          ),
                          Text(
                            '  Iniciar Sesión con Google',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      child: Container(
                        height: 30,
                        child: Row(
                          children: [
                            Text(
                              '¿No tienes Cuenta? ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              'Crear Nueva Cuenta',
                              style: TextStyle(fontSize: 15, color: colorPrimary),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/RegisterPage');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
