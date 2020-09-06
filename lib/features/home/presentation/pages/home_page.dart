import 'package:busmart/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          GestureDetector(
            child: Icon(Icons.highlight_off),
            onTap: () {
              _bloc.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Container(),
      ),
    );
  }
}
