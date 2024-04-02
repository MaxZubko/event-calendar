import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:event_calendar_app/constants/constants.dart' as constants;

class DateTimeSectionBottomSheet extends StatelessWidget {
  final String title;
  final DateTime initDate;
  final TimeOfDay initTime;
  final VoidCallback onTapFirestBtn;
  final VoidCallback onTapSecondBtn;
  const DateTimeSectionBottomSheet({
    super.key,
    required this.title,
    required this.onTapFirestBtn,
    required this.onTapSecondBtn,
    required this.initDate,
    required this.initTime,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall,
        ),
        const Expanded(child: SizedBox()),
        GestureDetector(
          onTap: onTapFirestBtn,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
                color: constants.Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Text(
              _formatDate(initDate),
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: onTapSecondBtn,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
                color: constants.Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Text(_formatTime(context, initTime),
                style: theme.textTheme.bodyMedium),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    String formattedDate = DateFormat('d MMM y').format(date);
    return formattedDate;
  }

  String _formatTime(BuildContext context, TimeOfDay time) {
    String formattedTime = time.format(context);
    return formattedTime;
  }
}
