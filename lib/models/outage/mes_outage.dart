/// A single scheduled power outage window for a locality.
class CebOutage {
  final DateTime startDatetime;
  final DateTime endDatetime;
  final String locality;
  final List<String> streets;

  const CebOutage({
    required this.startDatetime,
    required this.endDatetime,
    required this.locality,
    required this.streets,
  });

  factory CebOutage.fromJson(Map<String, dynamic> json) => CebOutage(
    startDatetime: DateTime.parse(json['start_datetime'] as String),
    endDatetime: DateTime.parse(json['end_datetime'] as String),
    locality: json['locality'] as String,
    streets: List<String>.from(json['streets'] as List),
  );

  Map<String, dynamic> toJson() => {
    'start_datetime': startDatetime.toIso8601String(),
    'end_datetime': endDatetime.toIso8601String(),
    'locality': locality,
    'streets': streets,
  };
}
