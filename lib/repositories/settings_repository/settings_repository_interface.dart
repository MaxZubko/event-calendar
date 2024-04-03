abstract interface class SettingsRepositoryInterface {
  Future<bool> isDarkThemeSelected();
  Future<void> setThemeSelected(bool selected);
}
