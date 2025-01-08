import 'package:mauritius_emergency_services/core/models/locale.dart';
import 'package:mauritius_emergency_services/core/models/settings.dart';
import 'package:mauritius_emergency_services/core/models/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsRepository {
  Future<MesSettings> getSettings();
  Future<void> updateSettings(MesSettings settings);
}

// Repository implementation
class SettingsRepositoryImpl implements SettingsRepository {
  static const _keyDynamicEnabled = 'isDynamicEnabled';
  static const _keyTheme = 'theme';
  static const _keyLocale = 'locale'; // Add new key
  final SharedPreferences _prefs;

  SettingsRepositoryImpl(this._prefs);

  @override
  Future<MesSettings> getSettings() async {
    final isDynamicEnabled = _prefs.getBool(_keyDynamicEnabled) ?? false;
    final themeIndex = _prefs.getInt(_keyTheme) ?? 0;
    final localeIndex = _prefs.getInt(_keyLocale) ?? 0; // Add locale retrieval

    return MesSettings(
      isDynamicEnabled: isDynamicEnabled,
      theme: MesThemes.values[themeIndex],
      locale: MesLocale.values[localeIndex], // Add locale to return
    );
  }

  @override
  Future<void> updateSettings(MesSettings settings) async {
    await _prefs.setBool(_keyDynamicEnabled, settings.isDynamicEnabled);
    await _prefs.setInt(_keyTheme, settings.theme.index);
    await _prefs.setInt(
        _keyLocale, settings.locale.index); // Add locale storage
  }
}
