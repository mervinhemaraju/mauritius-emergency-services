class CycloneGuidelines {
  final int level;
  final String description;
  final List<String> precautions;

  const CycloneGuidelines({
    required this.level,
    required this.description,
    required this.precautions,
  });

  factory CycloneGuidelines.fromJson(Map<String, dynamic> json) {
    return CycloneGuidelines(
      level: json['level'],
      description: json['description'],
      precautions: List<String>.from(json['precautions']),
    );
  }
}
