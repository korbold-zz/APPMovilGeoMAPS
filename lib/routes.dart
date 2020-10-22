import 'package:busmart/features/home/presentation/pages/home_page.dart';
import 'package:busmart/features/login/presentation/widgets/passwordReset_page.dart';
import 'package:busmart/features/register/presentation/pages/register_page.dart';
import 'package:busmart/main.dart';
import 'package:flutter/material.dart';

routes<String, WidgetBuilder>(
  BuildContext context,
) {
  return {
    '/': (context) => HomeVerify(),
    '/home': (context) => HomePage.init(context),
    '/RegisterPage': (context) => RegisterPage.init(context),
    '/PasswordResetPage': (context) => PasswordResetPage(),
  };
}
