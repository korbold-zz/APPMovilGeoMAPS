import 'package:busmart/features/register/domain/repositories/register_domain_respositoryINTERFACE.dart';
import 'package:busmart/features/register/presentation/bloc/register_bloc.dart';
import 'package:busmart/theme/constants.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegistrerBloc(
          Provider.of<RegisterDomainRepositoryINTERFACE>(context)),
      builder: (_, __) => RegisterPage._(),
    );
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final dni = TextEditingController(text: '');

  final firstName = TextEditingController(text: '');

  final lastName = TextEditingController(text: '');

  final email = TextEditingController(text: '');

  final numberCell = TextEditingController(text: '');

  final numberCellCodeCountry = TextEditingController(text: '');

  final username = TextEditingController(text: '');

  final password = TextEditingController(text: '');

  final dateBirth = TextEditingController(text: '');

  final _formKey = GlobalKey<FormState>();
  final _scaffolKey = GlobalKey<ScaffoldState>();
  String _editDate;
  @override
  void initState() {
    _editDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    dateBirth.text = DateFormat.yMMMMEEEEd('es').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectDate() async {
      DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1910),
        lastDate: new DateTime(2021),
        locale: Locale('es'),
      );
      setState(() {
        if (picked != null) {
          _editDate = DateFormat('yyyy-MM-dd').format(picked);
          dateBirth.text = DateFormat.yMMMMEEEEd('es').format(picked);
        }
      });
    }

    final registerBloc = Provider.of<RegistrerBloc>(context);

    return SafeArea(
      child: Scaffold(
        key: _scaffolKey,
        // appBar: AppBar(title: Text('Registro')),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              size: 25,
                              color: colorPrimary,
                            ),
                            onPressed: () => Navigator.of(context).pop()),
                        Image.asset(
                          'assets/img/logoBlue.png',
                          height: 50,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Regístrate',
                            style: TextStyle(
                                fontSize: 30,
                                color: colorPrimary,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    _TextForm(
                      labelText: 'Cédula/Pasaporte',
                      textEditingController: dni,
                      textInputType: TextInputType.number,
                      textInputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        LengthLimitingTextInputFormatter(10),
                      ],
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
                    GestureDetector(
                      child: Stack(alignment: Alignment.center, children: [
                        _TextForm(
                          labelText: 'Fecha de Nacimiento',
                          textEditingController: dateBirth,
                          textCapitalization: TextCapitalization.words,
                          readOnly: true,
                        ),
                        Container(
                          height: 50,
                          color: Colors.transparent,
                        )
                      ]),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        selectDate();
                      },
                    ),
                    _TextForm(
                      labelText: 'Correo Electrónico',
                      textEditingController: email,
                      textInputType: TextInputType.emailAddress,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          elevation: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: CountryCodePicker(
                              onChanged: (e) =>
                                  numberCellCodeCountry.text = e.toString(),
                              initialSelection: 'EC',
                              showCountryOnly: true,
                              favorite: ['+593', 'EC'],
                            ),
                          ),
                        ),
                        Expanded(
                          child: _TextForm(
                            labelText: 'Celular',
                            textEditingController: numberCell,
                            textInputType: TextInputType.number,
                            hintText: '987654321',
                            textInputFormatter: <TextInputFormatter>[
                              FilteringTextInputFormatter.deny('0'),
                              LengthLimitingTextInputFormatter(9),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _TextForm(
                      labelText: 'Usuario',
                      textEditingController: username,
                    ),
                    _TextForm(
                      labelText: 'Contraseña',
                      textEditingController: password,
                    ),
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: null),
                        Expanded(
                          child: Text(
                            'Aceptas los términos y condiciones de Busmart',
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                    RaisedButton(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 110),
                        color: colorPrimary,
                        child: Text(
                          'Registrarme',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            final result = await registerBloc.sendRegisterData(
                                dateBirth: _editDate,
                                dni: dni.text,
                                email: email.text,
                                firstName: firstName.text,
                                lastName: lastName.text,
                                numberCell: (numberCellCodeCountry.text +
                                    numberCell.text),
                                password: password.text,
                                userName: username.text);
                            if (result) {
                              _scaffolKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                  "Registrado con éxito \nInicie Sesión Por favor!",
                                ),
                              ));
                              await Future.delayed(Duration(seconds: 4))
                                  .then((_) {
                                Navigator.of(context).pop();
                              });
                            } else {
                              _scaffolKey.currentState.showSnackBar(SnackBar(
                                content: Text(
                                  "No se pudo Registrar",
                                ),
                              ));
                            }
                          }
                        })
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

class _TextForm extends StatelessWidget {
  const _TextForm({
    Key key,
    this.labelText,
    this.textInputType,
    this.textCapitalization = TextCapitalization.none,
    this.textEditingController,
    this.textInputFormatter,
    this.hintText,
    this.readOnly = false,
  }) : super(key: key);

  final String labelText;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final TextEditingController textEditingController;
  final List<TextInputFormatter> textInputFormatter;
  final String hintText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: TextFormField(
        readOnly: readOnly,
        controller: textEditingController,
        textCapitalization: textCapitalization,
        keyboardType: textInputType,
        inputFormatters: textInputFormatter,
        validator: (value) {
          if (value.isEmpty) {
            return 'Campo Obligatorio';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }
}
