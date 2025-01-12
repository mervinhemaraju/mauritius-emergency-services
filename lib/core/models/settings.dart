// Settings model
import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/locale.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';

class MesSettings {
  final bool isOnboarded;
  final bool isDynamicEnabled;
  final ThemeMode theme;
  final MesLocale locale;
  final Service emergencyButtonAction;

  const MesSettings({
    required this.isOnboarded,
    required this.isDynamicEnabled,
    required this.theme,
    required this.locale,
    required this.emergencyButtonAction,
  });

  MesSettings copyWith({
    bool? isOnboarded,
    bool? isDynamicEnabled,
    ThemeMode? theme,
    MesLocale? locale,
    Service? emergencyButtonAction,
  }) {
    return MesSettings(
      isOnboarded: isOnboarded ?? this.isOnboarded,
      isDynamicEnabled: isDynamicEnabled ?? this.isDynamicEnabled,
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
      emergencyButtonAction:
          emergencyButtonAction ?? this.emergencyButtonAction,
    );
  }

  // Update default settings
  factory MesSettings.initial() {
    return const MesSettings(
      isOnboarded: false,
      isDynamicEnabled: false,
      theme: ThemeMode.system,
      locale: MesLocale.english,
      emergencyButtonAction: Service(),
    );
  }
}
