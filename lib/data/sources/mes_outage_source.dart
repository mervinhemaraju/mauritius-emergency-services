import 'package:mauritius_emergency_services/models/outage/mes_district_outage.dart';

/// Contract for any data source that can provide CEB power outage data.
abstract class CebOutageSource {
  Future<List<CebDistrictOutage>> getOutages(String lang);
}
