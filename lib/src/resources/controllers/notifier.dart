import 'package:flutter/widgets.dart';

abstract class NotifierController {
  VoidCallback _notify;

  void register(VoidCallback setState) => _notify = setState;

  void notify() {
    try {
      _notify?.call();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
