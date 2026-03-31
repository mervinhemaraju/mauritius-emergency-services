import 'package:mauritius_emergency_services/data/contracts/alerts/mes_alert_repository.dart';
import 'package:mauritius_emergency_services/data/contracts/alerts/mes_alert_source.dart';
import 'package:mauritius_emergency_services/data/contracts/services/mes_service_repository.dart';

class MesAlertImpl implements MesAlertRepository {
  final MesAlertSource remoteSource;

  const MesAlertImpl({required this.remoteSource});

  @override
  Future<String?> getAlert([String lang = defaultLanguage]) =>
      remoteSource.getAlert(lang);
}
