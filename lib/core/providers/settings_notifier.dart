import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsRepository {
  Future<MesSettings> getSettings();
  Future<void> updateSettings(MesSettings settings);
}

// Repository implementation
class SettingsRepositoryImpl implements SettingsRepository {
  static const _keyDynamicEnabled = 'isDynamicEnabled';
  final SharedPreferences _prefs;

  SettingsRepositoryImpl(this._prefs);

  @override
  Future<MesSettings> getSettings() async {
    final isDynamicEnabled = _prefs.getBool(_keyDynamicEnabled) ?? false;
    return MesSettings(isDynamicEnabled: isDynamicEnabled);
  }

  @override
  Future<void> updateSettings(MesSettings settings) async {
    await _prefs.setBool(_keyDynamicEnabled, settings.isDynamicEnabled);
  }
}

// Repository provider
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  throw UnimplementedError('Repository must be initialized');
});

// Settings notifier
class MesSettingsNotifier extends StateNotifier<MesSettings> {
  final SettingsRepository _repository;

  MesSettingsNotifier(this._repository) : super(MesSettings.initial()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    state = await _repository.getSettings();
  }

  Future<void> toggleDynamic(bool value) async {
    final newSettings = state.copyWith(isDynamicEnabled: value);
    await _repository.updateSettings(newSettings);
    state = newSettings;
  }
}

// Settings provider
final settingsProvider =
    StateNotifierProvider<MesSettingsNotifier, MesSettings>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return MesSettingsNotifier(repository);
});
