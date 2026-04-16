import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/core/models/cyclone/cyclone_report.freezed.dart';

@freezed
abstract class MesCycloneReport with _$MesCycloneReport {
  const factory MesCycloneReport({
    required int level,
    required List<String> news,
    String? nextBulletin,
  }) = _MesCycloneReport;

  const MesCycloneReport._();

  factory MesCycloneReport.fromJson(Map<String, dynamic> json) {
    // Handle the custom logic for next_bulletin
    var nextBulletin = json['next_bulletin'] as String?;
    nextBulletin = nextBulletin ?? '00:00:00';

    return MesCycloneReport(
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
