import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MesSettingsNotifier extends StateNotifier<MesSettings> {
  MesSettingsNotifier() : super(MesSettings.defaults()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('mesSettings');

    if (jsonString != null) {
      final jsonMap = Map<String, dynamic>.from(
        jsonDecode(jsonString) as Map,
      );
      state = MesSettings.fromJson(jsonMap);
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(state.toJson());
    await prefs.setString('mesSettings', jsonString);
  }

  Future<void> updateDynamicEnabled(bool value) async {
    state = state.copyWith(isDynamicEnabled: value);
    await _saveSettings();
  }
}

final mesSettingsProvider =
    StateNotifierProvider<MesSettingsNotifier, MesSettings>((ref) {
  return MesSettingsNotifier();
});
