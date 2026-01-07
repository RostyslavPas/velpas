import 'package:intl/intl.dart';

class Formatters {
  static String km(int value) {
    final formatter = NumberFormat.decimalPattern();
    return formatter.format(value);
  }

  static String price(num value, {String currencyCode = 'USD'}) {
    final formatter = NumberFormat.currency(
      symbol: _currencySymbol(currencyCode),
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  static String _currencySymbol(String code) {
    switch (code) {
      case 'EUR':
        return '€';
      case 'UAH':
        return '₴';
      case 'USD':
      default:
        return '\$';
    }
  }

  static String dateTime(DateTime value) {
    final formatter = DateFormat('MMM d, HH:mm');
    return formatter.format(value);
  }
}
