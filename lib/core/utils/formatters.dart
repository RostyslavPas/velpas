import 'package:intl/intl.dart';

class Formatters {
  static String km(int value) {
    final formatter = NumberFormat.decimalPattern();
    return formatter.format(value);
  }

  static String price(num value) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    return formatter.format(value);
  }

  static String dateTime(DateTime value) {
    final formatter = DateFormat('MMM d, HH:mm');
    return formatter.format(value);
  }
}
