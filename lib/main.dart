import 'package:busmart/features/home/presentation/bloc/home_bloc.dart';
import 'package:busmart/features/home/presentation/pages/home_page.dart';
import 'package:busmart/features/login/data/repositories/login_data_repositoy_impl.dart';
import 'package:busmart/features/login/domain/repositories/login_domain_repository.dart';
import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:busmart/features/login/presentation/bloc/login_event.dart';
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
        Provider<LoginDomainRepository>(
            create: (_) => LoginDataRepositoryImpl()),

        ChangeNotifierProvider(create: (_) => HomeBloc()),
        ChangeNotifierProvider(create: (_) => LoginEvent()),
        // ChangeNotifierProvider(create: (_) => CameraMoveEvent()),
      ],
      child: Builder(builder: (nContext) {
        return ConsumerSelect.init(nContext);
      }),
    );
  }
}

class ConsumerSelect extends StatelessWidget {
  ConsumerSelect._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginBloc(Provider.of<LoginDomainRepository>(context)),
      builder: (_, __) => ConsumerSelect._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
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
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(),
      ),
    );
  }
}
