import 'package:intl/intl.dart';

class DateConverterHelper {
  static String convertDate(DateTime? dateTime) {
    if (dateTime != null) {
      return DateFormat.yMMMd().format(dateTime);
    }

    return '';
  }
}
