import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mauritius_emergency_services/ui/utils/convertors.dart';

part '../../generated/models/outage/mes_outage.freezed.dart';
part '../../generated/models/outage/mes_outage.g.dart';

@freezed
abstract class CebOutage with _$CebOutage {
  const factory CebOutage({
    @DateTimeConverter()
    @JsonKey(name: 'start_datetime')
    required DateTime startDatetime,
    @DateTimeConverter()
    @JsonKey(name: 'end_datetime')
    required DateTime endDatetime,
    required String locality,
    required List<String> streets,
  }) = _CebOutage;

  factory CebOutage.fromJson(Map<String, dynamic> json) =>
      _$CebOutageFromJson(json);
}
