import 'package:flutter/material.dart';

class CalendarWeekDays extends StatelessWidget {
  const CalendarWeekDays({super.key});

  final List<String> _weekDays = const [
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
    'Su'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: _weekDays
          .map(
            (day) => Expanded(
              child: Center(
                child: Text(
                  day,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
