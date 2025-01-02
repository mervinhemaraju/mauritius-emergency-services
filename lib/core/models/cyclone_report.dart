class CycloneReport {
  final int level;
  final String? nextBulletin;
  final List<String> news;

  const CycloneReport({
    required this.level,
    required this.news,
    this.nextBulletin,
  });

  factory CycloneReport.fromJson(Map<String, dynamic> json) {
    return CycloneReport(
      level: json['level'],
      nextBulletin: json['next_bulletin'],
      news: json['news'],
    );
  }
}
