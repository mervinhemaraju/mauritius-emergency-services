import 'package:mauritius_emergency_services/core/models/settings.dart';
import 'package:mauritius_emergency_services/core/models/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsRepository {
  Future<MesSettings> getSettings();
  Future<void> updateSettings(MesSettings settings);
}

class SettingsRepositoryImpl implements SettingsRepository {
  static const _keyDynamicEnabled = 'isDynamicEnabled';
  static const _keyTheme = 'theme';
  final SharedPreferences _prefs;

  SettingsRepositoryImpl(this._prefs);

  @override
  Future<MesSettings> getSettings() async {
    final isDynamicEnabled = _prefs.getBool(_keyDynamicEnabled) ?? false;
    final themeIndex = _prefs.getInt(_keyTheme) ?? 0;

    return MesSettings(
      isDynamicEnabled: isDynamicEnabled,
      theme: MesThemes.values[themeIndex],
    );
  }

  @override
  Future<void> updateSettings(MesSettings settings) async {
    await _prefs.setBool(_keyDynamicEnabled, settings.isDynamicEnabled);
    await _prefs.setInt(_keyTheme, settings.theme.index);
  }
}
