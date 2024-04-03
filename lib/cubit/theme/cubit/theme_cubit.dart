import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_calendar_app/repositories/settings_repository/settings.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required SettingsRepositoryInterface settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(const ThemeState(Brightness.light)) {
    _checkSelectedTheme();
  }

  final SettingsRepositoryInterface _settingsRepository;

  Future<void> setThemeBrightness(Brightness brightness) async {
    try {
      emit(ThemeState(brightness));
      await _settingsRepository.setThemeSelected(
        brightness == Brightness.dark,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  void _checkSelectedTheme() async {
    try {
      final brightness = await _settingsRepository.isDarkThemeSelected()
          ? Brightness.dark
          : Brightness.light;
      emit(ThemeState(brightness));
    } catch (e) {
      throw Exception(e);
    }
  }
}
