import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatTime(BuildContext context, DateTime dateTime) {
    final is24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    final formattedTime =
        DateFormat(is24HourFormat ? 'HH:mm' : 'h:mm a').format(dateTime);
    return formattedTime;
  }
}
