import 'package:mauritius_emergency_services/core/models/outage/mes_district_outage.dart';

abstract class CebOutageRepository {
  Future<List<CebDistrictOutage>> getOutages([String lang]);
}
