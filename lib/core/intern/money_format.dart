import 'package:intl/intl.dart';

class MoneyFormat {
  static String formatRupiahFromString(String value) {
    final number = num.tryParse(value) ?? 0;
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(number);
  }
}
