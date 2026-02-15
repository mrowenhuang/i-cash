import 'package:intl/intl.dart';

class AccountAndToken {
  String getExpiredDate(String startDate, int days) {
    final start = DateTime.parse(startDate);
    final expired = start.add(Duration(days: days));
    return DateFormat("EEEE, d MMMM yyyy", "id_ID").format(expired);
  }

  bool isStillValid(String startDate, int days) {
    final expired = DateTime.parse(startDate).add(Duration(days: days));
    final now = DateTime.now();

    return expired.isAfter(DateTime(now.year, now.month, now.day));
  }
}
