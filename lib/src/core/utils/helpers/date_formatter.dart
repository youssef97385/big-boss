import 'package:intl/intl.dart';

String formatDate(DateTime? expiration) {
  var formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(expiration ?? DateTime.now());
}
