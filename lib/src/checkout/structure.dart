import 'package:flutter/material.dart';
import 'package:vega/src/checkout/summary.dart';

class CheckoutStructure extends StatelessWidget {
  final String title;
  final Widget actions;
  final Widget content;

  final SummaryData summary;
  final String actionText;
  final VoidCallback onActionPressed;

  CheckoutStructure({
    @required this.title,
    @required this.actions,
    @required this.content,
    @required this.summary,
    @required this.actionText,
    this.onActionPressed,
  });

  Widget _title(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
        ),
        child: Tooltip(
          message: title,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 24.0,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Material(
        color: Theme.of(context).primaryColorDark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            actions,
            _title(context),
            Expanded(child: content),
            CheckoutSummary(
              summary: summary,
              actionText: actionText,
              onActionPressed: onActionPressed,
            ),
          ],
        ),
      );
}
