class CycloneReport {
  final int level;
  final String? nextBulletin;
  final List<String> news;

  const CycloneReport({
    required this.level,
    required this.news,
    this.nextBulletin,
  });

  // Create a method that gets the hour and min from the nextBulletin
  String get getHour {
    final time = nextBulletin!.split(':');
    return time.isNotEmpty ? time[0] : '00';
  }

  String get getMinute {
    final time = nextBulletin!.split(':');
    return time.length > 1 ? time[1] : '00';
  }

  factory CycloneReport.fromJson(Map<String, dynamic> json) {
    // Get the next bulleting
    var next_bulletin = json['next_bulletin'] as String?;

    // Assign a default value if next_bulletin is null
    next_bulletin = next_bulletin ?? '00:00:00';

    return CycloneReport(
      level: json['level'] as int,
      nextBulletin: next_bulletin,
      news: List<String>.from(json['news'] as List),
    );
  }
}
