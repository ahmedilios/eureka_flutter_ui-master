import 'package:flutter/material.dart';

class ManageButton extends StatelessWidget {
  final VoidCallback onTap;

  const ManageButton({
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(
          top: 12.0,
          right: 12.0,
          left: 12.0,
          bottom: 0.0,
        ),
        child: Tooltip(
          message: 'Gerenciar',
          child: InkWell(
            onTap: onTap,
            customBorder: CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      );
}

class ReturnButton extends StatelessWidget {
  final VoidCallback onTap;

  const ReturnButton({
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => Container(
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
            onTap: onTap,
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
}
