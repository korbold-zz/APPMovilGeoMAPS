import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<LoginBloc>(context);
    return MaterialApp(
      home: Scaffold(
        body: IntroViewsFlutter(
          [
            _pageModel('sadasdasd1', 'afasfsdasd2', Colors.yellow),
            _pageModel('sada1', 'afffffsdasd3', Colors.blue),
            _pageModel('shhha1', 'agggggasd3', Colors.green)
          ],
          showNextButton: true,
          showSkipButton: true,
          onTapDoneButton: () {
            _bloc.setIsLogin = true;
          },
        ),
      ),
    );
  }
}

_pageModel(
  String text1,
  String text2,
  Color color,
) {
  return PageViewModel(
      pageColor: color,
      title: Text(text1),
      body: Text(text2),
      mainImage: FlutterLogo());
}
