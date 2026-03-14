import 'package:mauritius_emergency_services/models/service/service.dart';

/// Contract for any data source that can provide MES services.
/// Both remote (API) and local (cache) implementations conform to this.
abstract class MesServiceSource {
  Future<List<Service>> getAllServices(String lang);
}
