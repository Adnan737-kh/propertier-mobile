
import 'package:intl/intl.dart';

String formatDateToStandard(String? dateTimeString) {

  if(dateTimeString == null) return "";
  // Parse the input string to DateTime
  DateTime dateTime = DateTime.parse(dateTimeString!);

  // Format the DateTime object to "yyyy-MM-dd"
  return DateFormat('yyyy-MM-dd').format(dateTime);
}