import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo Obligatorio';
                    } else
                      return null;
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      print('hechos');
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
