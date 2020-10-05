import 'dart:io';

import 'package:busmart/features/home/data/repositories/home_data_repository_impl.dart';
import 'package:busmart/features/home/domain/repositories/home_domain_repository.dart';
import 'package:busmart/features/home/presentation/bloc/home_bloc.dart';
import 'package:busmart/features/home/presentation/pages/home_page.dart';
import 'package:busmart/features/login/data/repositories/login_data_repositoy_impl.dart';
import 'package:busmart/features/login/domain/repositories/login_domain_repository.dart';
import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:busmart/features/login/presentation/bloc/login_event.dart';
import 'package:busmart/features/login/presentation/widgets/intro_page.dart';
import 'package:busmart/routes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'features/home/presentation/bloc/home_event.dart';
import 'features/login/presentation/pages/login_page.dart';

void main() {
  // Directory appDocumentDir = await getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);
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

        Provider<HomeDomainRepositoryINTERFACE>(
          create: (_) => HomeDataRepositoryIMPL(),
        ),
        // ChangeNotifierProvider(create: (_) => HomeBloc()),
        ChangeNotifierProvider(create: (_) => LoginEvent()),
        ChangeNotifierProvider(create: (_)=> HomeCameraMoveEvent(),)
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
              return HomePage.init(context);
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
