import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/cyclone_report.freezed.dart';

@freezed
abstract class CycloneReport with _$CycloneReport {
  const factory CycloneReport({
    required int level,
    String? nextBulletin,
    required List<String> news,
  }) = _CycloneReport;

  const CycloneReport._();

  factory CycloneReport.fromJson(Map<String, dynamic> json) {
    // Handle the custom logic for next_bulletin
    var nextBulletin = json['next_bulletin'] as String?;
    nextBulletin = nextBulletin ?? '00:00:00';

    return CycloneReport(
      level: json['level'] as int,
      nextBulletin: nextBulletin,
      news: List<String>.from(json['news'] as List),
    );
  }

  // Custom getters
  String get getHour {
    final time = nextBulletin!.split(':');
    return time.isNotEmpty ? time[0] : '00';
  }

  String get getMinute {
    final time = nextBulletin!.split(':');
    return time.length > 1 ? time[1] : '00';
  }
}
