import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class CustomSnackBar {
  final Flushbar _customBar;

  CustomSnackBar(
    String message, {
    Color color = Colors.red,
  }) : _customBar = SimpleSnackBar.generateSnackBar(
          message,
          color: color,
        );

  void show(BuildContext context) => _customBar?.show(context);

  void hide() => _customBar?.dismiss();
}

class SimpleSnackBar {
  static Flushbar generateSnackBar(
    String message, {
    Color color = Colors.red,
    Duration duration,
    Function onDissmiss,
    bool top = false,
  }) =>
      Flushbar(
        message: message ?? 'Ocorreu um erro',
        backgroundColor: color,
        duration: duration,
        flushbarPosition: top ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
        onStatusChanged: (status) {
          if (status == FlushbarStatus.DISMISSED) {
            if (onDissmiss != null) {
              onDissmiss();
            }
          }
        },
      );

  static void show(
    BuildContext context,
    String message, {
    Color color = Colors.green,
    int duration = 3,
    Function onDismiss,
    bool top = false,
  }) =>
      generateSnackBar(
        message,
        color: color,
        duration: Duration(seconds: duration),
        onDissmiss: onDismiss,
        top: top,
      )..show(context);

  static void error(
    BuildContext context,
    String message, {
    int duration = 3,
    Function onDismiss,
    bool top = false,
  }) =>
      generateSnackBar(
        message,
        color: Colors.red,
        duration: Duration(seconds: duration),
        onDissmiss: onDismiss,
        top: top,
      )..show(context);
}
