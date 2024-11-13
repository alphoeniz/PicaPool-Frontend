class DateTimeHelper {
 
static String timeAgoSince(String iso8601String, {bool numericDates = true}) {
  DateTime date = DateTime.parse(iso8601String).toLocal();
  final now = DateTime.now().toLocal();
  final difference = now.difference(date);

  final seconds = difference.inSeconds;
  final minutes = difference.inMinutes;
  final hours = difference.inHours;
  final days = difference.inDays;

  if (seconds < 5) {
    return 'Just now';
  } else if (seconds < 60) {
    return '$seconds seconds ago';
  } else if (minutes < 2) {
    return numericDates ? '1 minute ago' : 'A minute ago';
  } else if (minutes < 60) {
    return '$minutes minutes ago';
  } else if (hours < 2) {
    return numericDates ? '1 hour ago' : 'An hour ago';
  } else if (hours < 24) {
    return '$hours hours ago';
  } else if (days < 2) {
    return numericDates ? '1 day ago' : 'Yesterday';
  } else if (days < 7) {
    return '$days days ago';
  } else if (days < 14) {
    return numericDates ? '1 week ago' : 'Last week';
  } else if (days < 30) {
    return '${(days / 7).ceil()} weeks ago';
  } else if (days < 60) {
    return numericDates ? '1 month ago' : 'Last month';
  } else if (days < 365) {
    return '${(days / 30).ceil()} months ago';
  } else if (days < 730) {
    return numericDates ? '1 year ago' : 'Last year';
  } else {
    return '${(days / 365).floor()} years ago';
  }
}


}