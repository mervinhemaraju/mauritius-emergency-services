import 'package:mauritius_emergency_services/models/service.dart';

// Defines the default language
const defaultLanguage = "en";

// Defines the repository for MES services
abstract class MesServiceRepository {
  // Gets a list of all MES services
  Future<List<Service>> getAllServices([String lang = defaultLanguage]);
}
