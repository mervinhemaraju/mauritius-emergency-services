class CycloneNames {
  final String name;
  final String gender;
  final String providedBy;
  final String namedBy;

  const CycloneNames({
    required this.name,
    required this.gender,
    required this.providedBy,
    required this.namedBy,
  });

  factory CycloneNames.fromJson(Map<String, dynamic> json) {
    return CycloneNames(
      name: json['name'],
      gender: json['gender'],
      providedBy: json['provided_by'],
      namedBy: json['named_by'],
    );
  }
}
