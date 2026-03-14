import 'package:mauritius_emergency_services/data/repository/mes_outage_repository.dart';
import 'package:mauritius_emergency_services/data/repository/mes_service_repository.dart';
import 'package:mauritius_emergency_services/data/sources/mes_outage_source.dart';
import 'package:mauritius_emergency_services/models/outage/mes_district_outage.dart';

class CebOutageImpl implements CebOutageRepository {
  final CebOutageSource remoteSource;

  const CebOutageImpl({required this.remoteSource});

  @override
  Future<List<CebDistrictOutage>> getOutages([String lang = defaultLanguage]) =>
      remoteSource.getOutages(lang);
}
