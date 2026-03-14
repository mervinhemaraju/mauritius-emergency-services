import 'package:mauritius_emergency_services/models/settings.dart';

abstract class AppSettingsRepository {
  Future<MesSettings> getSettings();
  Future<void> updateSettings(MesSettings settings);
}
