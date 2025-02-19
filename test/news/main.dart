import 'package:vega/vega.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Auth Test',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: NewsPage(
//              picture: 'https://i.redd.it/4sgdcmeyfqz41.jpg',
              picture:
                  'https://edit.co.uk/uploads/2015/07/ThinkstockPhotos-471871130.jpg',
              title: 'Uma notícia pra você',
              author: 'Rocardo Henroque',
              timestamp: '08 de Março de 2020',
              content:
                  '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a nunc vitae lectus rhoncus vulputate id faucibus lectus. Donec ultrices suscipit nisi nec pellentesque. Duis pellentesque turpis lacus, in facilisis erat accumsan quis. Maecenas et mi eu lectus feugiat convallis non eget tortor. Sed iaculis convallis ipsum in tempus. Integer at viverra dui. Etiam ac turpis nec est facilisis malesuada ut quis odio. Ut et nulla cursus, blandit massa ac, semper arcu. Quisque lacinia consequat mauris. Integer nec scelerisque risus, at dapibus nunc. Nulla pellentesque massa est, nec fringilla quam venenatis et. Curabitur malesuada ornare risus, in commodo massa posuere id. Praesent mattis aliquet nisi, vitae luctus nisi maximus sed. Vestibulum ac dignissim mi, et consectetur mauris.</p>'
                  '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a nunc vitae lectus rhoncus vulputate id faucibus lectus. Donec ultrices suscipit nisi nec pellentesque. Duis pellentesque turpis lacus, in facilisis erat accumsan quis. Maecenas et mi eu lectus feugiat convallis non eget tortor. Sed iaculis convallis ipsum in tempus. Integer at viverra dui. Etiam ac turpis nec est facilisis malesuada ut quis odio. Ut et nulla cursus, blandit massa ac, semper arcu. Quisque lacinia consequat mauris. Integer nec scelerisque risus, at dapibus nunc. Nulla pellentesque massa est, nec fringilla quam venenatis et. Curabitur malesuada ornare risus, in commodo massa posuere id. Praesent mattis aliquet nisi, vitae luctus nisi maximus sed. Vestibulum ac dignissim mi, et consectetur mauris.</p>'
                  '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a nunc vitae lectus rhoncus vulputate id faucibus lectus. Donec ultrices suscipit nisi nec pellentesque. Duis pellentesque turpis lacus, in facilisis erat accumsan quis. Maecenas et mi eu lectus feugiat convallis non eget tortor. Sed iaculis convallis ipsum in tempus. Integer at viverra dui. Etiam ac turpis nec est facilisis malesuada ut quis odio. Ut et nulla cursus, blandit massa ac, semper arcu. Quisque lacinia consequat mauris. Integer nec scelerisque risus, at dapibus nunc. Nulla pellentesque massa est, nec fringilla quam venenatis et. Curabitur malesuada ornare risus, in commodo massa posuere id. Praesent mattis aliquet nisi, vitae luctus nisi maximus sed. Vestibulum ac dignissim mi, et consectetur mauris.</p>'
                  '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a nunc vitae lectus rhoncus vulputate id faucibus lectus. Donec ultrices suscipit nisi nec pellentesque. Duis pellentesque turpis lacus, in facilisis erat accumsan quis. Maecenas et mi eu lectus feugiat convallis non eget tortor. Sed iaculis convallis ipsum in tempus. Integer at viverra dui. Etiam ac turpis nec est facilisis malesuada ut quis odio. Ut et nulla cursus, blandit massa ac, semper arcu. Quisque lacinia consequat mauris. Integer nec scelerisque risus, at dapibus nunc. Nulla pellentesque massa est, nec fringilla quam venenatis et. Curabitur malesuada ornare risus, in commodo massa posuere id. Praesent mattis aliquet nisi, vitae luctus nisi maximus sed. Vestibulum ac dignissim mi, et consectetur mauris.</p>',
            ),
          ),
        ),
      );
}
