import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';

import 'package:flutter/material.dart';

import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<LoginBloc>(context);
    return MaterialApp(
      home: Scaffold(
        body: IntroViewsFlutter(
          [
            _pageModel('Controla', 'la manera de como te movilizas.',
                'assets/animate/slide1.json'),
            _pageModel(
                'Selecciona',
                'la mejor ruta  para siempre llegar a tiempo.',
                'assets/animate/slide2.json'),
            _pageModel('Realiza', 'tus pagos de manera segura y precio justo.',
                'assets/animate/slide3.json')
          ],
          showSkipButton: true,
          nextText: Text('Siguiente'),
          backText: Text('Atrás'),
          doneText: Text('Listo'),
          skipText: Text('Omitir'),
          onTapDoneButton: () {
            _bloc.setIsLogin = true;
          },
        ),
      ),
    );
  }
}

_pageModel(String text, String text2, String route) {
  final styleLetter = TextStyle(fontSize: 17);
  return PageViewModel(
      pageColor: Color.fromRGBO(0, 131, 154, 1),
      title: Image.asset('assets/img/logo.png'),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              text,
              style: styleLetter.copyWith(
                  fontWeight: FontWeight.w800, fontSize: 30),
            ),
            Text(text2, style: styleLetter),
          ],
        ),
      ),
      mainImage: Lottie.asset(route));
}
