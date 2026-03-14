import 'package:mauritius_emergency_services/models/outage/mes_outage.dart';

class CebDistrictOutage {
  final String district;
  final List<CebOutage> outages;

  const CebDistrictOutage({required this.district, required this.outages});

  factory CebDistrictOutage.fromJson(Map<String, dynamic> json) =>
      CebDistrictOutage(
        district: json['district'] as String,
        outages: (json['outages'] as List)
            .map((o) => CebOutage.fromJson(o as Map<String, dynamic>))
            .toList(),
      );
}
