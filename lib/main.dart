import 'package:busmart/features/home/presentation/bloc/home_bloc.dart';
import 'package:busmart/features/home/presentation/pages/home_page.dart';
import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:busmart/features/login/presentation/widgets/intro_page.dart';
import 'package:busmart/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/login/presentation/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: routes(context),
      // home: HomeVerify(),
    );
  }
}

class HomeVerify extends StatefulWidget {
  @override
  _HomeVerifyState createState() => _HomeVerifyState();
}

class _HomeVerifyState extends State<HomeVerify> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginBloc.instance()),
        ChangeNotifierProvider(create: (_) => HomeBloc()),
      ],
      child: Consumer(
        // ignore: missing_return
        builder: (_, LoginBloc user, __) {
          if (user.isLogin) {
            switch (user.status) {
              case Status.Uninitialized:
                return Splash();
              case Status.Unauthenticated:
                return LoginPage();
              case Status.Authenticating:
                return LoginPage();
              case Status.Authenticated:
                return HomePage();
            }
          } else {
            return IntroPage();
          }
        },
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(),
      ),
    );
  }
}
