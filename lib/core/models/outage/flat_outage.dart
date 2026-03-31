import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mauritius_emergency_services/core/models/outage/mes_outage.dart';

part '../../../generated/core/models/outage/flat_outage.freezed.dart';

@freezed
abstract class MesFlatOutage with _$MesFlatOutage {
  const MesFlatOutage._();

  const factory MesFlatOutage({
    required String district,
    required CebOutage outage,
  }) = _MesFlatOutage;

  String get dateKey {
    final s = outage.startDatetime;
    return '${s.year}-${s.month.toString().padLeft(2, '0')}-${s.day.toString().padLeft(2, '0')}';
  }

  bool get isOngoing {
    final now = DateTime.now();
    return now.isAfter(outage.startDatetime) &&
        now.isBefore(outage.endDatetime);
  }

  bool get isPast => DateTime.now().isAfter(outage.endDatetime);
}
