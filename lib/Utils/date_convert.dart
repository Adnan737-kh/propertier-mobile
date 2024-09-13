import 'package:intl/intl.dart';

class DateConvert {
  String changeDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}
