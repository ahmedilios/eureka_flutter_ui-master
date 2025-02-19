import 'package:altair/altair.dart';
import 'package:vega/vega.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // ignore: close_sinks
  AuthBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = AuthBloc(authRepository: AuthMock());
  }

  @override
  void dispose() {
    super.dispose();

    _bloc?.close();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Auth Test',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: BlocProvider(
              create: (BuildContext context) => _bloc,
              child: SignInPage(
                bloc: _bloc,
//                appBar: AppBar(
//                  title: Text(
//                    'Auth Test',
//                    textAlign: TextAlign.start,
//                    overflow: TextOverflow.ellipsis,
//                    maxLines: 1,
//                  ),
//                ),
                title: Text(
                  'Bem-vindo!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ),
        ),
      );
}
