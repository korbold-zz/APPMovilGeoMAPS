import 'package:busmart/features/register/presentation/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final dni = TextEditingController(text: '');
  final firstName = TextEditingController(text: '');
  final lastName = TextEditingController(text: '');
  final email = TextEditingController(text: '');
  final numberCell = TextEditingController(text: '');
  final username = TextEditingController(text: '');
  final password = TextEditingController(text: '');
  final dateBirth = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegistrerBloc(),
      builder: (context, __) {
        final registerBloc = Provider.of<RegistrerBloc>(context, listen: false);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(title: Text('Registro')),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _TextForm(
                        labelText: 'Cédula/Pasaporte',
                        textEditingController: dni,
                        textInputType: TextInputType.number,
                      ),
                      _TextForm(
                        labelText: 'Nombre',
                        textEditingController: firstName,
                        textCapitalization: TextCapitalization.words,
                      ),
                      _TextForm(
                        labelText: 'Apellidos',
                        textEditingController: lastName,
                        textCapitalization: TextCapitalization.words,
                      ),
                      _TextForm(
                        labelText: 'Fecha de Nacimiento',
                        textEditingController: dateBirth,
                        textCapitalization: TextCapitalization.words,
                      ),
                      _TextForm(
                        labelText: 'Correo Electrónico',
                        textEditingController: email,
                        textInputType: TextInputType.emailAddress,
                      ),
                      _TextForm(
                        labelText: 'Celular',
                        textEditingController: numberCell,
                        textInputType: TextInputType.number,
                      ),
                      _TextForm(
                        labelText: 'Usuario',
                        textEditingController: username,
                      ),
                      _TextForm(
                        labelText: 'Contraseña',
                        textEditingController: password,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                            child: Text('Registrarme'),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                registerBloc.sendRegisterData(
                                    dateBirth: dateBirth.text,
                                    dni: dni.text,
                                    email: email.text,
                                    firstName: firstName.text,
                                    lastName: lastName.text,
                                    numberCell: numberCell.text,
                                    password: password.text,
                                    userName: username.text);
                              }
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
