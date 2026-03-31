import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mauritius_emergency_services/core/models/app/locale.dart';
import 'package:mauritius_emergency_services/core/models/service/service.dart';

part '../../../generated/core/models/app/settings.freezed.dart';

@freezed
abstract class MesSettings with _$MesSettings {
  /*
    This is the settings model class which 
    represents the app settings functionalities
  */
  const factory MesSettings({
    required bool disclaimerAcknowledged,
    required bool isAwareOfNewFeature,
    required bool isOnboarded,
    required bool isDynamicEnabled,
    required ThemeMode theme,
    required MesLocale locale,
    required Service emergencyButtonAction,
  }) = _MesSettings;

  factory MesSettings.initial() => const MesSettings(
    disclaimerAcknowledged: false,
    isAwareOfNewFeature: false,
    isOnboarded: false,
    isDynamicEnabled: false,
    theme: ThemeMode.system,
    locale: MesLocale.english,
    emergencyButtonAction: Service(),
  );
}
