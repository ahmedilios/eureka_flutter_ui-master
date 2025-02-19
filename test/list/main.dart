import 'package:altair/altair.dart';
import 'package:vega/vega.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../post/bloc.dart';
import '../post/model.dart';
import '../post/repository.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // ignore: close_sinks
  PostBloc postBloc;

  @override
  void initState() {
    super.initState();

    this.postBloc = PostBloc(PostRepository());

    this.postBloc.add(LoadEvent());
  }

  @override
  void dispose() {
    super.dispose();

    this.postBloc?.close();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'List Test',
        theme: ThemeData(
          primaryColor: Colors.purple,
          accentColor: Colors.purple,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: BlocProvider<
                SimpleBloc<PostShort, PostDetailed,
                    SimpleRepository<PostShort, PostDetailed>>>(
              create: (BuildContext context) => this.postBloc,
              child: BlocListWidget.separated(
                bloc: this.postBloc,
                title: 'Últimas notícias',
                onCreate: () {
                  print('create');
                },
                separatorBuilder: (context) => Divider(
                  color: Colors.grey.withOpacity(0.25),
                  height: 1.0,
                  indent: 16.0,
                  endIndent: 16.0,
                ),
                itemBuilder: ListWidget.defaultItemBuilder(
                  getTitle: (item) => item.title,
                  onDetails: (item) => () {
                    print('open details for ${item.title}');
                  },
                  onEditItem: (item) => () {
                    print('editar ${item.title}');
                  },
                  onDeleteItem: (item) => () {
                    print('deletar ${item.title}');
                  },
                ),
              ),
            ),
          ),
        ),
      );
}
