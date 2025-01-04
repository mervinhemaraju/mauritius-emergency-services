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

  // Add JSON serialization for SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'isDynamicEnabled': isDynamicEnabled,
    };
  }

  factory MesSettings.fromJson(Map<String, dynamic> json) {
    return MesSettings(
      isDynamicEnabled: json['isDynamicEnabled'] as bool? ?? false,
    );
  }

  // Default settings
  factory MesSettings.defaults() {
    return const MesSettings(isDynamicEnabled: false);
  }
}
