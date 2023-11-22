import 'package:intl/intl.dart';

String formatDate(DateTime? expiration) {
  var formatter = DateFormat('DD-Mon-YYYY', 'en');
  return formatter.format(expiration ?? DateTime.now());
}
