import 'package:flutter/material.dart';
import 'package:vega/src/checkout/common.dart';

class NewCardScreen extends StatefulWidget {
  final VoidCallback onBackPressed;
  final void Function(String, String, String, String) onActionPressed;

  NewCardScreen({
    @required this.onBackPressed,
    @required this.onActionPressed,
  });

  @override
  _NewCardScreenState createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  TextEditingController numberController;
  TextEditingController nameController;
  TextEditingController validController;
  TextEditingController ccvController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController()
      ..addListener(() => setState(() {}));

    numberController = TextEditingController()
      ..addListener(() => setState(() {}));

    validController = TextEditingController()
      ..addListener(() => setState(() {}));

    ccvController = TextEditingController()..addListener(() => setState(() {}));
  }

  Widget _title(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
        ),
        child: Tooltip(
          message: 'Cartão de Crédito',
          child: Text(
            'Cartão de Crédito',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 24.0,
            ),
          ),
        ),
      );

  Widget _labeledValue(String label, String value) => Column(
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: Colors.black26,
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            value,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      );

  String get paddedNumber => numberController.text.padRight(16, '-');

  WidgetSpan get numberSpacing => WidgetSpan(child: SizedBox(width: 16.0));

  @override
  Widget build(BuildContext context) => Material(
        color: Theme.of(context).primaryColorDark,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ReturnButton(onTap: widget.onBackPressed),
              _title(context),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.credit_card),
                      const SizedBox(height: 8.0),
                      Center(
                        child: Text.rich(TextSpan(
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          children: <InlineSpan>[
                            TextSpan(text: paddedNumber.substring(0, 4)),
                            numberSpacing,
                            TextSpan(text: paddedNumber.substring(4, 8)),
                            numberSpacing,
                            TextSpan(text: paddedNumber.substring(8, 12)),
                            numberSpacing,
                            TextSpan(text: this.paddedNumber.substring(12, 16)),
                          ],
                        )),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _labeledValue(
                              'NOME',
                              nameController.text,
                            ),
                          ),
                          Expanded(
                            child: _labeledValue(
                              'VENCIMENTO',
                              validController.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(4.0),
                  ),
                ),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: numberController,
                      decoration: InputDecoration(
                        labelText: 'Número',
                        hintText: '0000 0000 0000 0000',
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        hintText: 'João da Silva',
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: validController,
                            decoration: InputDecoration(
                              labelText: 'Validade',
                              hintText: 'mm/YYYY',
                            ),
                          ),
                        ),
                        const SizedBox(width: 24.0),
                        Expanded(
                          child: TextFormField(
                            controller: ccvController,
                            decoration: InputDecoration(
                              labelText: 'CCV',
                              hintText: 'XXX',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      child: FlatButton(
                        color: Theme.of(context).primaryColorDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(64.0),
                        ),
                        onPressed: () => widget.onActionPressed(
                          nameController.text,
                          numberController.text,
                          validController.text,
                          ccvController.text,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'SALVAR',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
