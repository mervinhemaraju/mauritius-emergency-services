import 'package:mauritius_emergency_services/models/outage/mes_district_outage.dart';

abstract class CebOutageRepository {
  Future<List<CebDistrictOutage>> getOutages([String lang]);
}
