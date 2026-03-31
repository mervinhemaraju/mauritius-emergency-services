import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/data/contracts/settings/app_settings_repository.dart';
import 'package:mauritius_emergency_services/core/models/app/locale.dart';
import 'package:mauritius_emergency_services/core/models/service/service.dart';
import 'package:mauritius_emergency_services/core/models/app/settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/data/local/preferences/settings_provider.g.dart';

@riverpod
AppSettingsRepository settingsRepository(Ref ref) {
  throw UnimplementedError(
    'settingsRepositoryProvider must be overridden at app initialisation.',
  );
}

@riverpod
class MesSettingsNotifier extends _$MesSettingsNotifier {
  late final AppSettingsRepository _repository;

  @override
  MesSettings build() {
    _repository = ref.watch(settingsRepositoryProvider);
    _loadSettings();
    return MesSettings.initial();
  }

  Future<void> _loadSettings() async {
    state = await _repository.getSettings();
  }

  Future<void> markDisclaimerAsRead() =>
      _update(state.copyWith(disclaimerAcknowledged: true));

  Future<void> markAsAwareOfNewFeature() =>
      _update(state.copyWith(isAwareOfNewFeature: true));

  Future<void> markAsOnboarded() => _update(state.copyWith(isOnboarded: true));

  Future<void> toggleDynamic(bool value) =>
      _update(state.copyWith(isDynamicEnabled: value));

  Future<void> updateTheme(ThemeMode theme) =>
      _update(state.copyWith(theme: theme));

  Future<void> updateLocale(MesLocale locale) =>
      _update(state.copyWith(locale: locale));

  Future<void> updateEmergencyButtonAction(MesService service) =>
      _update(state.copyWith(emergencyButtonAction: service));

  Future<void> _update(MesSettings newSettings) async {
    await _repository.updateSettings(newSettings);
    state = newSettings;
  }
}
