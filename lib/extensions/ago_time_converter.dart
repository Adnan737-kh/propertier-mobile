import 'package:timeago/timeago.dart' as timeago;

String getTimeAgo(DateTime uploadedDate) {
  // final difference = DateTime.now().difference(uploadedDate);
  return timeago.format(uploadedDate); // Optional for localization
}
