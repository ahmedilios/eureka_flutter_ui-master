import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class SummaryData {
  final String subtotal;
  final String total;
  final List<Tuple2<String, String>> items;

  const SummaryData({
    @required this.subtotal,
    @required this.total,
    this.items = const [],
  });
}

class CheckoutSummary extends StatelessWidget {
  final SummaryData summary;
  final String actionText;
  final VoidCallback onActionPressed;

  CheckoutSummary({
    @required this.summary,
    @required this.actionText,
    this.onActionPressed,
  });

  Widget _summaryItem(String label, String value) {
    final left = Tooltip(
      message: label,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black38,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    final right = Tooltip(
      message: value,
      child: Text(
        value,
        style: TextStyle(
          color: Colors.black38,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 2.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[left, right],
      ),
    );
  }

  Widget _totalRow(
    BuildContext context,
    String label,
    String value,
  ) {
    final left = Tooltip(
      message: label,
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final right = Tooltip(
      message: value,
      child: Text(
        value,
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[left, right],
    );
  }

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColorLight,
        padding: const EdgeInsets.only(
          top: 0.0,
          left: 24.0,
          right: 24.0,
          bottom: 64.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(4.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Transform(
                transform: Matrix4.translationValues(0.0, 12.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                      ),
                      child: Tooltip(
                        message: 'Resumo do pedido',
                        child: Text(
                          'Resumo do pedido',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    _summaryItem('SUBTOTAL', summary.subtotal),
                    ...summary.items
                        .map((pair) => _summaryItem(pair.item1, pair.item2))
                        .toList(),
                    Divider(
                      thickness: 1.0,
                      height: 24.0,
                      color: Colors.black12,
                    ),
                    _totalRow(context, 'TOTAL', summary.total),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Transform(
                transform: Matrix4.translationValues(0.0, 24.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: FlatButton(
                    color: Theme.of(context).primaryColorDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(64.0),
                    ),
                    onPressed: onActionPressed,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        actionText,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
