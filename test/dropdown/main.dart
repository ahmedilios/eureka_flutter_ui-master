import 'package:flutter/material.dart';
import 'package:vega/vega.dart';

void main() => runApp(
      MaterialApp(
        home: DropDownForm(),
      ),
    );

class DropDownForm extends StatefulWidget {
  @override
  _DropDownFormState createState() => _DropDownFormState();
}

class _DropDownFormState extends State<DropDownForm> {
  final formKey = GlobalKey<FormState>();
  DropDownController controller;

  @override
  void initState() {
    super.initState();
    controller = DropDownController<DropDownItemInt>(
      requireSelect: true,
    );
    controller.items = List<DropDownItemInt>.from(
      [1, 2, 3].map((value) => DropDownItemInt.homonymous(value)),
    );
    // This won't work, 'cause banana is not a valid value
    controller.selectByValue('banana');
    // This would work, 'cause 2 is in the value set
    // controller.selectByValue(2);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              DropDownWidget(
                controller: controller,
                style: VegaInputStyle(
                  innerDecoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textStyle: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              RaisedButton(
                child: Text("Validar"),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    print('Seleção válida!');
                  }
                },
              )
            ],
          ),
        ),
      );
}
