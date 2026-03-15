import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mauritius_emergency_services/models/outage/mes_outage.dart';

part '../../generated/models/outage/mes_district_outage.freezed.dart';
part '../../generated/models/outage/mes_district_outage.g.dart';

@freezed
abstract class CebDistrictOutage with _$CebDistrictOutage {
  const factory CebDistrictOutage({
    required String district,
    required List<CebOutage> outages,
  }) = _CebDistrictOutage;

  factory CebDistrictOutage.fromJson(Map<String, dynamic> json) =>
      _$CebDistrictOutageFromJson(json);
}
