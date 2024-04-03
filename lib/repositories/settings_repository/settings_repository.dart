import 'package:event_calendar_app/constants/constants.dart';
import 'package:event_calendar_app/repositories/settings_repository/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository implements SettingsRepositoryInterface {
  @override
  Future<bool> isDarkThemeSelected() async {
    // TODO take out the SharedPreferences instance
    final sharedPrefs = await SharedPreferences.getInstance();
    final selected = sharedPrefs.getBool(SHARED_PREF_THEME_KEY);
    return selected ?? false;
  }

  @override
  Future<void> setThemeSelected(bool selected) async {
    // TODO take out the SharedPreferences instance
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool(SHARED_PREF_THEME_KEY, selected);
  }
}
