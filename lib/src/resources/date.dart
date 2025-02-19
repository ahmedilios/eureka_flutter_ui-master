import 'package:intl/intl.dart';

class VegaDateResources {
  static bool parseExpiry(String text) {
    if (text?.isEmpty ?? true) return false;
    try {
      final d = DateFormat.yM().parseStrict(text);
      final dnow = DateTime.now();
      if (dnow.year > d.year) return false;
      if (dnow.year == d.year) {
        return d.month >= dnow.month;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool parseExpiryYearAbbreviated(String text) {
    if (text?.isEmpty ?? true) return false;
    try {
      final d = DateFormat.yM().parseStrict(text.replaceFirst('/', '/20'));
      final dnow = DateTime.now();
      if (dnow.year > d.year) return false;
      if (dnow.year == d.year) {
        return d.month >= dnow.month;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
