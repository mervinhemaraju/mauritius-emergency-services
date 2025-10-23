import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/models/locale.dart';
import 'package:mauritius_emergency_services/models/service.dart';
import 'package:mauritius_emergency_services/models/settings.dart';
import 'package:mauritius_emergency_services/data/repository/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsImpl implements AppSettingsRepository {
  static const _keyDisclaimerAcknowledged =
      'disclaimerAcknowledged';
  static const _keyIsOnboarded = 'isOnboarded';
  static const _keyDynamicEnabled = 'isDynamicEnabled';
  static const _keyTheme = 'theme';
  static const _keyLocale = 'locale';
  static const _keyEmergencyButtonAction =
      'emergencyButtonAction';
  final SharedPreferences _prefs;

  AppSettingsImpl(this._prefs);

  @override
  Future<MesSettings> getSettings() async {
    final disclaimerAcknowledged =
        _prefs.getBool(_keyDisclaimerAcknowledged) ?? false;
    final isOnboarded = _prefs.getBool(_keyIsOnboarded) ?? false;
    final isDynamicEnabled =
        _prefs.getBool(_keyDynamicEnabled) ?? false;
    final themeIndex = _prefs.getInt(_keyTheme) ?? 0;
    final localeIndex = _prefs.getInt(_keyLocale) ?? 0;
    final String? serviceJson = _prefs.getString(
      _keyEmergencyButtonAction,
    );

    Service? emergencyButtonAction = serviceJson == null
        ? const Service()
        : Service.fromJson(jsonDecode(serviceJson));

    return MesSettings(
      disclaimerAcknowledged: disclaimerAcknowledged,
      isOnboarded: isOnboarded,
      isDynamicEnabled: isDynamicEnabled,
      theme: ThemeMode.values[themeIndex],
      locale: MesLocale.values[localeIndex],
      emergencyButtonAction: emergencyButtonAction,
    );
  }

  @override
  Future<void> updateSettings(MesSettings settings) async {
    await _prefs.setBool(
      _keyDisclaimerAcknowledged,
      settings.disclaimerAcknowledged,
    );
    await _prefs.setBool(_keyIsOnboarded, settings.isOnboarded);
    await _prefs.setBool(
      _keyDynamicEnabled,
      settings.isDynamicEnabled,
    );
    await _prefs.setInt(_keyTheme, settings.theme.index);
    await _prefs.setInt(_keyLocale, settings.locale.index);
    await _prefs.setString(
      _keyEmergencyButtonAction,
      jsonEncode(settings.emergencyButtonAction.toJson()),
    );
  }
}
