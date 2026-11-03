import 'package:time/time.dart';

String formatTimeAgo({required DateTime date}) {
  final delta = DateTime.now().difference(date);

  if (delta.inMinutes < 1) {
    return 'Just Now';
  }
  if (delta < 60.minutes) {
    return '${delta.inMinutes} mins ago';
  }
  if (delta < 24.hours) {
    return '${delta.inHours} hours ago';
  }
  if (delta < 7.days) {
    return '${delta.inDays} days ago';
  }
  if (delta < 30.days) {
    return '${(delta.inDays / 7).floor()} weeks ago';
  }
  if (delta < 365.days) {
    return '${(delta.inDays / 30).floor()} months ago';
  }
  return '${(delta.inDays / 365).floor()} years ago';
}
