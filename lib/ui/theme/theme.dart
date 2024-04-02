import 'package:flutter/material.dart';
import 'package:event_calendar_app/constants/constants.dart' as constants;

final darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    color: constants.Colors.dark,
    titleTextStyle: _textTheme.headlineMedium,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: constants.Colors.darkLight,
  ),
  textTheme: _textTheme,
  scaffoldBackgroundColor: constants.Colors.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: constants.Colors.white,
    brightness: Brightness.dark,
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    color: constants.Colors.white,
    titleTextStyle: _textTheme.headlineMedium,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  textTheme: _textTheme,
  scaffoldBackgroundColor: constants.Colors.white,
  dividerTheme: DividerThemeData(
    color: Colors.grey.withOpacity(0.1),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: constants.Colors.white,
    brightness: Brightness.light,
  ),
);

const _textTheme = TextTheme(
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: constants.Colors.grey,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: constants.Colors.grey,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: constants.Colors.redSelected,
    ));
