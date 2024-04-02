import 'package:intl/intl.dart';

/// [DateTimeUtils] to format time from DateTime to 00:00 format depending
/// on whether the time format on the device is 24 hours or 12 hours
class DateTimeUtils {
  static String formatTime(
      {required bool is24HourFormat, required DateTime dateTime}) {
    final formattedTime =
        DateFormat(is24HourFormat ? 'HH:mm' : 'h:mm a').format(dateTime);
    return formattedTime;
  }
}
