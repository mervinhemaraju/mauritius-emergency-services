import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/data/contracts/settings/app_settings_repository.dart';
import 'package:mauritius_emergency_services/core/models/app/locale.dart';
import 'package:mauritius_emergency_services/core/models/service/service.dart';
import 'package:mauritius_emergency_services/core/models/app/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsImpl implements AppSettingsRepository {
  static const _keyDisclaimerAcknowledged = 'disclaimerAcknowledged';
  static const _keyIsAwareOfNewFeature = 'isAwareOfNewFeature';
  static const _keyIsOnboarded = 'isOnboarded';
  static const _keyDynamicEnabled = 'isDynamicEnabled';
  static const _keyTheme = 'theme';
  static const _keyLocale = 'locale';
  static const _keyEmergencyButtonAction = 'emergencyButtonAction';

  final SharedPreferences _prefs;

  const AppSettingsImpl(this._prefs);

  @override
  Future<MesSettings> getSettings() async {
    final disclaimerAcknowledged =
        _prefs.getBool(_keyDisclaimerAcknowledged) ?? false;
    final isAwareOfNewFeature =
        _prefs.getBool(_keyIsAwareOfNewFeature) ?? false;
    final isOnboarded = _prefs.getBool(_keyIsOnboarded) ?? false;
    final isDynamicEnabled = _prefs.getBool(_keyDynamicEnabled) ?? false;
    final themeIndex = _prefs.getInt(_keyTheme) ?? 0;
    final localeIndex = _prefs.getInt(_keyLocale) ?? 0;
    final serviceJson = _prefs.getString(_keyEmergencyButtonAction);

    final emergencyButtonAction = serviceJson == null
        ? const MesService()
        : MesService.fromJson(jsonDecode(serviceJson) as Map<String, dynamic>);

    return MesSettings(
      disclaimerAcknowledged: disclaimerAcknowledged,
      isAwareOfNewFeature: isAwareOfNewFeature,
      isOnboarded: isOnboarded,
      isDynamicEnabled: isDynamicEnabled,
      theme: ThemeMode.values[themeIndex],
      locale: MesLocale.values[localeIndex],
      emergencyButtonAction: emergencyButtonAction,
    );
  }

  @override
  Future<void> updateSettings(MesSettings settings) async {
    await Future.wait([
      _prefs.setBool(
        _keyDisclaimerAcknowledged,
        settings.disclaimerAcknowledged,
      ),
      _prefs.setBool(_keyIsAwareOfNewFeature, settings.isAwareOfNewFeature),
      _prefs.setBool(_keyIsOnboarded, settings.isOnboarded),
      _prefs.setBool(_keyDynamicEnabled, settings.isDynamicEnabled),
      _prefs.setInt(_keyTheme, settings.theme.index),
      _prefs.setInt(_keyLocale, settings.locale.index),
      _prefs.setString(
        _keyEmergencyButtonAction,
        jsonEncode(settings.emergencyButtonAction.toJson()),
      ),
    ]);
  }
}
