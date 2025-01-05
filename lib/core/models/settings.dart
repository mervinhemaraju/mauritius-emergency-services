class MesSettings {
  final bool isDynamicEnabled;

  const MesSettings({
    required this.isDynamicEnabled,
  });

  MesSettings copyWith({
    bool? isDynamicEnabled,
  }) {
    return MesSettings(
      isDynamicEnabled: isDynamicEnabled ?? this.isDynamicEnabled,
    );
  }

  // Default settings
  factory MesSettings.initial() {
    return const MesSettings(isDynamicEnabled: false);
  }
}
