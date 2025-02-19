import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:vega/src/checkout/default_cart_item.dart';
import 'package:vega/src/checkout/structure.dart';
import 'package:vega/src/checkout/summary.dart';

class CheckoutCart<T> extends StatelessWidget {
  final List<T> items;

  final Widget Function(BuildContext, T) itemBuilder;

  final String Function(BuildContext, T) itemPicture;
  final String Function(BuildContext, T) itemName;
  final String Function(BuildContext, T) itemQuantity;
  final String Function(BuildContext, T) itemSubtotal;
  final String Function(BuildContext, T) itemTotal;

  final void Function(T) onItemTap;

  final SummaryData summary;
  final VoidCallback onBackPressed;
  final VoidCallback onActionPressed;

  CheckoutCart({
    @required this.items,
    this.itemBuilder,
    this.itemPicture,
    this.itemName,
    this.itemQuantity,
    this.itemSubtotal,
    this.itemTotal,
    this.onItemTap,
    this.summary,
    this.onBackPressed,
    this.onActionPressed,
  }) : assert((itemBuilder != null &&
                (itemPicture == null &&
                    itemName == null &&
                    itemQuantity == null &&
                    itemSubtotal == null &&
                    itemTotal == null &&
                    onItemTap == null)) ||
            (itemBuilder == null &&
                (itemPicture != null &&
                    itemName != null &&
                    itemQuantity != null &&
                    itemSubtotal != null &&
                    itemTotal != null)));

  Widget _backButton(BuildContext context) => Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(
          top: 12.0,
          right: 12.0,
          left: 12.0,
          bottom: 0.0,
        ),
        child: Tooltip(
          message: 'Voltar',
          child: InkWell(
            onTap: onBackPressed,
            customBorder: CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => CheckoutStructure(
        title: 'Carrinho (${items.length})',
        actions: _backButton(context),
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          margin: const EdgeInsets.all(24.0),
          padding: const EdgeInsets.all(4.0),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: Column(
                children: itemBuilder != null
                    ? items
                        .map<Widget>((T i) => itemBuilder(context, i))
                        .toList()
                    : enumerate(items)
                        .map<Widget>((IndexedValue<T> item) => DefaultCartItem(
                              picture: itemPicture(context, item.value),
                              name: itemName(context, item.value),
                              quantity: itemQuantity(context, item.value),
                              subtotal: itemSubtotal(context, item.value),
                              total: itemTotal(context, item.value),
                              iconSize: constraints.biggest.width * 0.1,
                              even: item.index % 2 == 0,
                              onTap: () => onItemTap(item.value),
                            ))
                        .toList(),
              ),
            ),
          ),
        ),
        summary: summary,
        onActionPressed: onActionPressed,
        actionText: 'CONTINUAR',
      );
}
