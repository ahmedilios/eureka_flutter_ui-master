import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DefaultCartItem extends StatelessWidget {
  final String picture;
  final String name;
  final String quantity;
  final String subtotal;
  final String total;

  final bool even;
  final double iconSize;

  final VoidCallback onTap;

  const DefaultCartItem({
    @required this.picture,
    @required this.name,
    @required this.quantity,
    @required this.subtotal,
    @required this.total,
    @required this.even,
    @required this.iconSize,
    @required this.onTap,
  });

  Widget get _quantity => Tooltip(
        message: quantity,
        child: Text(
          quantity,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 12.0,
          ),
        ),
      );

  Widget get _times => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4.0,
        ),
        child: Text(
          'x',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10.0,
          ),
        ),
      );

  Widget get _subtotal => Tooltip(
        message: subtotal,
        child: Text(
          subtotal,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  Widget get _total => Tooltip(
        message: total,
        child: Text(
          total,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  Widget get _leading => Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: CachedNetworkImageProvider(picture),
          ),
        ),
      );

  Widget get _label => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Tooltip(
          message: name,
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18.0,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Material(
        color: even ? Colors.transparent : Colors.black.withOpacity(0.06),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _leading,
                Expanded(child: _label),
                Column(
                  children: <Widget>[
                    Row(children: <Widget>[_quantity, _times, _subtotal]),
                    const SizedBox(height: 4.0),
                    _total,
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
