import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key key}) : super(key: key);

  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _editTextController = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  final _scaffolKey = GlobalKey<ScaffoldState>();

  void menssage(String text) {
    _scaffolKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = LoginBloc.instance();
    return SafeArea(
      child: Scaffold(
        key: _scaffolKey,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _TextForm(
                  labelText: 'Correo Electrónico',
                  textEditingController: _editTextController,
                  textInputType: TextInputType.emailAddress,
                ),
                RaisedButton(
                    child: Text('Recuperar Contraseña'),
                    onPressed: () async {
                      if (await _bloc.sendPasswordReset(
                          email: _editTextController.text)) {
                        menssage('Revisa tu correo electrónico');
                      } else {
                        menssage('No podemos verificar tu correo no existe!');
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TextForm extends StatelessWidget {
  const _TextForm({
    Key key,
    this.labelText,
    this.textInputType,
    this.textCapitalization = TextCapitalization.none,
    this.textEditingController,
  }) : super(key: key);

  final String labelText;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      textCapitalization: textCapitalization,
      keyboardType: textInputType,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo Obligatorio';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(labelText: labelText),
    );
  }
}
