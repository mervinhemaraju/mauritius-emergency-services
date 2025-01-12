import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/locale.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/models/settings.dart';
import 'package:mauritius_emergency_services/data/repository/settings_repository.dart';

class MesSettingsNotifier extends StateNotifier<MesSettings> {
  final SettingsRepository _repository;

  MesSettingsNotifier(this._repository) : super(MesSettings.initial()) {
    _loadSettings();
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

  // Add new method to update locale
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

// Repository provider
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  throw UnimplementedError('Repository must be initialized');
});

// Settings provider
final settingsProvider =
    StateNotifierProvider<MesSettingsNotifier, MesSettings>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return MesSettingsNotifier(repository);
});
