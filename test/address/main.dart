import 'package:vega/src/styles/input.dart';
import 'package:vega/vega.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final controller = AddressDataController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Address Test',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    AddressDataForm(
                      controller: controller,
                      runSpacing: 10.0,
                      style: VegaInputStyle(
                        innerDecoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      child: Text('Save'),
                      onPressed: () {
                        if (_key.currentState.validate()) {
                          print(controller.generated);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
