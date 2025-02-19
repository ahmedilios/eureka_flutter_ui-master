import 'package:flutter/material.dart';

class DefaultPaymentItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;

  final double iconSize;

  final VoidCallback onTap;

  const DefaultPaymentItem({
    @required this.title,
    @required this.subtitle,
    @required this.selected,
    @required this.iconSize,
    @required this.onTap,
  });

  Widget get _leading => Container(
        width: iconSize,
        height: iconSize,
        child: Icon(Icons.credit_card),
      );

  Widget get _title => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Tooltip(
          message: title,
          child: Text(
            title,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.0,
            ),
          ),
        ),
      );

  Widget get _subtitle => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Tooltip(
          message: subtitle.toUpperCase(),
          child: Text(
            subtitle.toUpperCase(),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 10.0,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4.0),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _leading,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[_title, _subtitle],
                  ),
                ),
                Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black26, width: 2.0),
                  ),
                  child: selected
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      );
}
