import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/locale.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/models/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsRepository {
  Future<MesSettings> getSettings();
  Future<void> updateSettings(MesSettings settings);
}

// Repository implementation
class SettingsRepositoryImpl implements SettingsRepository {
  static const _keyIsOnboarded = 'isOnboarded';
  static const _keyDynamicEnabled = 'isDynamicEnabled';
  static const _keyTheme = 'theme';
  static const _keyLocale = 'locale';
  static const _keyEmergencyButtonAction = 'emergencyButtonAction';
  final SharedPreferences _prefs;

  SettingsRepositoryImpl(this._prefs);

  @override
  Future<MesSettings> getSettings() async {
    final isOnboarded = _prefs.getBool(_keyIsOnboarded) ?? false;
    final isDynamicEnabled = _prefs.getBool(_keyDynamicEnabled) ?? false;
    final themeIndex = _prefs.getInt(_keyTheme) ?? 0;
    final localeIndex = _prefs.getInt(_keyLocale) ?? 0;
    final String? serviceJson = _prefs.getString(_keyEmergencyButtonAction);

    Service? emergencyButtonAction = serviceJson == null
        ? Service()
        : Service.fromJson(jsonDecode(serviceJson));

    return MesSettings(
      isOnboarded: isOnboarded,
      isDynamicEnabled: isDynamicEnabled,
      theme: ThemeMode.values[themeIndex],
      locale: MesLocale.values[localeIndex],
      emergencyButtonAction: emergencyButtonAction,
    );
  }

  @override
  Future<void> updateSettings(MesSettings settings) async {
    await _prefs.setBool(_keyIsOnboarded, settings.isOnboarded);
    await _prefs.setBool(_keyDynamicEnabled, settings.isDynamicEnabled);
    await _prefs.setInt(_keyTheme, settings.theme.index);
    await _prefs.setInt(
      _keyLocale,
      settings.locale.index,
    );
    await _prefs.setString(
      _keyEmergencyButtonAction,
      jsonEncode(settings.emergencyButtonAction.toJson()),
    );
  }
}
