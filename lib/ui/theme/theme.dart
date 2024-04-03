import 'package:flutter/material.dart';
import 'package:event_calendar_app/constants/constants.dart' as constants;

final darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    color: constants.Colors.dark,
    titleTextStyle: _textTheme.headlineMedium,
    iconTheme: const IconThemeData(
      color: constants.Colors.white,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: constants.Colors.greenSelected,
    unselectedItemColor: constants.Colors.white,
    backgroundColor: constants.Colors.dark,
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
      color: constants.Colors.dark,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: constants.Colors.redSelected,
    unselectedItemColor: constants.Colors.dark,
    backgroundColor: constants.Colors.white,
  ),
  textTheme: _textTheme,
  scaffoldBackgroundColor: constants.Colors.white,
  dividerTheme: DividerThemeData(
    color: constants.Colors.grey.withOpacity(0.5),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: constants.Colors.white,
    brightness: Brightness.light,
  ),
);

const _textTheme = TextTheme(
  headlineMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  ),
  titleLarge: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  ),
  titleMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
  titleSmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  ),
  bodyLarge: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  labelMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
);
