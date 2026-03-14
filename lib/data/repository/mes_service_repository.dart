import 'package:mauritius_emergency_services/models/service/service.dart';

const defaultLanguage = "en";

abstract class MesServiceRepository {
  Future<List<Service>> getAllServices([String lang = defaultLanguage]);
}
