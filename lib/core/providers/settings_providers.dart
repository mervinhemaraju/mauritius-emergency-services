import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/locale.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/models/settings.dart';
import 'package:mauritius_emergency_services/data/repository/app_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'settings_providers.g.dart';

@riverpod
AppSettingsRepository settingsRepository(Ref ref) {
  throw UnimplementedError('Repository must be initialized');
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

  Future<void> markAsOnboarded() async {
    final newSettings = state.copyWith(isOnboarded: true);
    await _repository.updateSettings(newSettings);
    state = newSettings;
  }

  Future<void> toggleDynamic(bool value) async {
    final newSettings = state.copyWith(isDynamicEnabled: value);
    await _repository.updateSettings(newSettings);
    state = newSettings;
  }

  Future<void> updateTheme(ThemeMode theme) async {
    final newSettings = state.copyWith(theme: theme);
    await _repository.updateSettings(newSettings);
    state = newSettings;
  }

  Future<void> updateLocale(MesLocale locale) async {
    final newSettings = state.copyWith(locale: locale);
    await _repository.updateSettings(newSettings);
    state = newSettings;
  }

  Future<void> updateEmergencyButtonAction(Service service) async {
    final newSettings = state.copyWith(emergencyButtonAction: service);
    await _repository.updateSettings(newSettings);
    state = newSettings;
  }
}

// // Repository provider - this remains unchanged as it's already using Provider
// final settingsRepositoryProvider = Provider<AppSettingsRepository>((ref) {
//   throw UnimplementedError('Repository must be initialized');
// });

// // Settings provider - updated to use NotifierProvider
// final settingsProvider = NotifierProvider<MesSettingsNotifier, MesSettings>(() {
//   return MesSettingsNotifier();
// });
