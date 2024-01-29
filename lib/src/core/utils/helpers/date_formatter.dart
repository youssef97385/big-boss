import 'package:intl/intl.dart';

String formatDate(DateTime? expiration) {
  var formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(expiration ?? DateTime.now());
}

String formatDateWithHour(DateTime? expiration) {
  var formatter = DateFormat('yyyy-MM-dd-hh:mm');
  return formatter.format(expiration ?? DateTime.now());
}

String formatDateText(DateTime? expiration) {
  var formatter = DateFormat('d MMM y');
  return formatter.format(expiration ?? DateTime.now());
}
