import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:vega/src/checkout/common.dart';
import 'package:vega/src/checkout/default_payment_item.dart';
import 'package:vega/src/checkout/structure.dart';
import 'package:vega/src/checkout/summary.dart';

class CheckoutPayment<T> extends StatelessWidget {
  final List<T> items;

  final Widget Function(BuildContext, T) itemBuilder;

  final String Function(BuildContext, T) itemTitle;
  final String Function(BuildContext, T) itemSubtitle;
  final bool Function(BuildContext, T) itemSelected;

  final void Function(T) onItemTap;

  final SummaryData summary;
  final VoidCallback onBackPressed;
  final VoidCallback onManagePressed;
  final VoidCallback onActionPressed;

  CheckoutPayment({
    @required this.items,
    this.itemBuilder,
    this.itemTitle,
    this.itemSubtitle,
    this.itemSelected,
    this.onItemTap,
    this.summary,
    this.onBackPressed,
    this.onManagePressed,
    this.onActionPressed,
  }) : assert((itemBuilder != null &&
                (itemTitle == null &&
                    itemSubtitle == null &&
                    itemSelected == null &&
                    onItemTap == null)) ||
            (itemBuilder == null &&
                (itemTitle != null &&
                    itemSubtitle != null &&
                    itemSelected != null)));

  @override
  Widget build(BuildContext context) => CheckoutStructure(
        title: 'Pagamento',
        actions: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ReturnButton(onTap: onBackPressed),
            ManageButton(onTap: onManagePressed),
          ],
        ),
        content: Container(
          margin: const EdgeInsets.all(24.0),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: Column(
                children: items.isNotEmpty
                    ? (itemBuilder != null
                        ? items
                            .map<Widget>((T i) => itemBuilder(context, i))
                            .toList()
                        : enumerate(items)
                            .map<Widget>((IndexedValue<T> item) =>
                                DefaultPaymentItem(
                                  title: itemTitle(context, item.value),
                                  subtitle: itemSubtitle(context, item.value),
                                  selected: itemSelected(context, item.value),
                                  iconSize: constraints.biggest.width * 0.1,
                                  onTap: () => onItemTap(item.value),
                                ))
                            .fold<List<Widget>>(
                                [],
                                (acc, elem) => acc
                                  ..add(elem)
                                  ..add(const SizedBox(height: 4.0))).toList()
                      ..removeLast())
                    : [],
              ),
            ),
          ),
        ),
        summary: summary,
        onActionPressed: onActionPressed,
        actionText: 'COMPLETAR',
      );
}
