// Settings model
import 'package:mauritius_emergency_services/core/models/locale.dart';
import 'package:mauritius_emergency_services/core/models/themes.dart';

class MesSettings {
  final bool isDynamicEnabled;
  final MesThemes theme;
  final MesLocale locale; // Add new field

  const MesSettings({
    required this.isDynamicEnabled,
    required this.theme,
    required this.locale, // Add to constructor
  });

  MesSettings copyWith({
    bool? isDynamicEnabled,
    MesThemes? theme,
    MesLocale? locale, // Add to copyWith
  }) {
    return MesSettings(
      isDynamicEnabled: isDynamicEnabled ?? this.isDynamicEnabled,
      theme: theme ?? this.theme,
      locale: locale ?? this.locale, // Add to copyWith return
    );
  }

  // Update default settings
  factory MesSettings.initial() {
    return const MesSettings(
      isDynamicEnabled: false,
      theme: MesThemes.followSystem,
      locale: MesLocale.english, // Add default locale
    );
  }
}
