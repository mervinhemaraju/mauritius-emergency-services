import 'package:mauritius_emergency_services/core/models/service/service.dart';

const defaultLanguage = "en";

abstract class MesServiceRepository {
  Future<List<MesService>> getAllServices([String lang = defaultLanguage]);
}
