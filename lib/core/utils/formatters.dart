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
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'CHF':
        return 'CHF';
      case 'CNY':
        return '¥';
      case 'HKD':
        return r'HK$';
      case 'SGD':
        return r'S$';
      case 'KRW':
        return '₩';
      case 'INR':
        return '₹';
      case 'THB':
        return '฿';
      case 'IDR':
        return 'Rp';
      case 'MYR':
        return 'RM';
      case 'PHP':
        return '₱';
      case 'CAD':
        return r'CA$';
      case 'AUD':
        return r'A$';
      case 'NZD':
        return r'NZ$';
      case 'MXN':
        return r'MX$';
      case 'BRL':
        return r'R$';
      case 'ARS':
        return r'AR$';
      case 'CLP':
        return r'CLP$';
      case 'COP':
        return r'COP$';
      case 'PLN':
        return 'zł';
      case 'CZK':
        return 'Kč';
      case 'HUF':
        return 'Ft';
      case 'SEK':
        return 'kr';
      case 'NOK':
        return 'kr';
      case 'DKK':
        return 'kr';
      case 'RON':
        return 'lei';
      case 'EUR':
        return '€';
      case 'TRY':
        return '₺';
      case 'AED':
        return 'AED';
      case 'SAR':
        return 'SAR';
      case 'ILS':
        return '₪';
      case 'ZAR':
        return 'R';
      case 'EGP':
        return 'E£';
      case 'NGN':
        return '₦';
      case 'UAH':
        return '₴';
      case 'USD':
      default:
        return code == 'USD' ? '\$' : code;
    }
  }

  static String dateTime(DateTime value) {
    final formatter = DateFormat('MMM d, HH:mm');
    return formatter.format(value);
  }
}
