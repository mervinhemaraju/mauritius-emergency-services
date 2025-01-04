import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs => _prefs!;
}

// Settings notifier that handles the state and persistence
class MesSettingsNotifier extends StateNotifier<bool> {
  static const _key = 'isDynamicEnabled';

  MesSettingsNotifier() : super(false) {
    _loadInitialValue();
  }

  void _loadInitialValue() {
    state = PreferencesService.prefs.getBool(_key) ?? false;
  }

  Future<void> toggle(bool value) async {
    await PreferencesService.prefs.setBool(_key, value);
    state = value;
  }
}

final settingsProvider =
    StateNotifierProvider<MesSettingsNotifier, bool>((ref) {
  return MesSettingsNotifier();
});
