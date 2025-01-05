// Settings model
import 'package:mauritius_emergency_services/core/models/themes.dart';

class MesSettings {
  final bool isDynamicEnabled;
  final MesThemes theme;

  const MesSettings({
    required this.isDynamicEnabled,
    required this.theme,
  });

  MesSettings copyWith({
    bool? isDynamicEnabled,
    MesThemes? theme,
  }) {
    return MesSettings(
      isDynamicEnabled: isDynamicEnabled ?? this.isDynamicEnabled,
      theme: theme ?? this.theme,
    );
  }

  // Default settings
  factory MesSettings.initial() {
    return const MesSettings(
      isDynamicEnabled: false,
      theme: MesThemes.followSystem,
    );
  }
}
