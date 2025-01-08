// Settings model
import 'package:mauritius_emergency_services/core/models/locale.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/models/themes.dart';

class MesSettings {
  final bool isDynamicEnabled;
  final MesThemes theme;
  final MesLocale locale;
  final Service emergencyButtonAction;

  const MesSettings({
    required this.isDynamicEnabled,
    required this.theme,
    required this.locale,
    required this.emergencyButtonAction,
  });

  MesSettings copyWith({
    bool? isDynamicEnabled,
    MesThemes? theme,
    MesLocale? locale,
    Service? emergencyButtonAction,
  }) {
    return MesSettings(
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
      isDynamicEnabled: false,
      theme: MesThemes.followSystem,
      locale: MesLocale.english,
      emergencyButtonAction: Service(),
    );
  }
}
