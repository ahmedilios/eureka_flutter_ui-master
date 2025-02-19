import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:vega/src/checkout/new_card.dart';
import 'package:vega/src/checkout/payment.dart';
import 'package:vega/src/checkout/summary.dart';
import 'package:vega/vega.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class Item {
  final String picture;
  final String name;
  final String quantity;
  final String subtotal;
  final String total;

  const Item({
    @required this.picture,
    @required this.name,
    @required this.quantity,
    @required this.subtotal,
    @required this.total,
  });
}

class Card {
  final int id;
  final String title;
  final String subtitle;

  const Card({
    @required this.id,
    @required this.title,
    @required this.subtitle,
  });
}

class _AppState extends State<App> {
  int _step;

  @override
  void initState() {
    super.initState();

    _step = 0;
  }

  VoidCallback _setStep(int value) => () => setState(() {
        _step = value;
      });

  Widget get _currentStep {
    switch (_step) {
      case 0:
        return CheckoutCart(
          items: List<Item>.generate(
            4,
            (i) => Item(
              picture:
                  'http://www.vectorico.com/download/social_media/Reddit-Icon.png',
              name: 'Reddit Gold',
              quantity: '2',
              subtotal: 'R\$ 2.50',
              total: 'R\$ 5.00',
            ),
          ),
          itemPicture: (_, item) => item.picture,
          itemName: (_, item) => item.name,
          itemQuantity: (_, item) => item.quantity,
          itemSubtotal: (_, item) => item.subtotal,
          itemTotal: (_, item) => item.total,
          onItemTap: (item) => print('click'),
          summary: SummaryData(
            subtotal: 'R\$ 100.00',
            total: 'R\$ 111.00',
            items: <Tuple2<String, String>>[
              Tuple2('IMPOSTOS', 'R\$ 1,00'),
              Tuple2('ENTREGA', 'R\$ 10,00'),
            ],
          ),
          onBackPressed: () {
            print('voltar');
          },
          onActionPressed: _setStep(1),
        );

      case 1:
        return CheckoutPayment(
          items: List<Card>.generate(
            3,
            (i) => Card(
              id: i,
              title: 'Credit Card **** 1234',
              subtitle: 'Bernard Watson',
            ),
          ),
          itemTitle: (_, item) => item.title,
          itemSubtitle: (_, item) => item.subtitle,
          itemSelected: (_, item) => item.id == 0,
          onItemTap: (item) => print('click'),
          summary: SummaryData(
            subtotal: 'R\$ 100.00',
            total: 'R\$ 111.00',
            items: <Tuple2<String, String>>[
              Tuple2('IMPOSTOS', 'R\$ 1,00'),
              Tuple2('ENTREGA', 'R\$ 10,00'),
            ],
          ),
          onBackPressed: _setStep(0),
          onManagePressed: _setStep(3),
          onActionPressed: _setStep(2),
        );

      case 2:
        return Container(
          child: Text("Successo!"),
        );

      case 3:
        return NewCardScreen(
          onActionPressed: (name, number, valid, ccv) {
            print('name: $name');
            print('number: $number');
            print('valid: $valid');
            print('ccv: $ccv');
          },
          onBackPressed: _setStep(1),
        );

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Auth Test',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: _currentStep,
          ),
        ),
      );
}
