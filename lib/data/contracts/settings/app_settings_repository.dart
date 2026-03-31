import 'package:mauritius_emergency_services/core/models/app/settings.dart';

abstract class AppSettingsRepository {
  Future<MesSettings> getSettings();
  Future<void> updateSettings(MesSettings settings);
}
