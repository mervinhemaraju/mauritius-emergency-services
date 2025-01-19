import 'package:mauritius_emergency_services/models/service.dart';

abstract class MesDataSource {
  // Gets a list of all MES services
  Future<List<Service>> getAllServices(String lang);
}
