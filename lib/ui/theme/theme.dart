import 'package:flutter/material.dart';
import 'package:event_calendar_app/constants/constants.dart' as constants;

const _scaffoldBackgroundColor = Color(0xFF1E1F25);

final darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: _scaffoldBackgroundColor,
    titleTextStyle: textTheme.headlineMedium,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  textTheme: textTheme,
  scaffoldBackgroundColor: _scaffoldBackgroundColor,
);

const textTheme = TextTheme(
  headlineMedium: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
  ),
  titleMedium: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: constants.Colors.grey,
  ),
);
