import 'package:intl/intl.dart';

class DateUtils {
  static String getDateMMDDByDate(DateTime date) {
    return DateFormat("MM-dd").format(date).toString();
  }

  static String getDateYYYYMMDDByDate(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date).toString();
  }
}
