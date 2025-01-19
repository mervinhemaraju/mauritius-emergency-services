import 'package:mauritius_emergency_services/models/service.dart';
import 'package:mauritius_emergency_services/models/db/service_model.dart';
import 'package:mauritius_emergency_services/data/sources/mes.dart';
import 'package:mauritius_emergency_services/generated/objectbox/objectbox.g.dart';

// Create a local data source implementation
class MesServiceLocalDataSource implements MesDataSource {
  final Store store;

  MesServiceLocalDataSource(this.store);

  @override
  Future<List<Service>> getAllServices(String lang) async {
    final box = store.box<ServiceModel>();
    final services =
        box.query(ServiceModel_.language.equals(lang)).build().find();

    return services.map((model) => model.toService()).toList();
  }

  Future<void> cacheServices(List<Service> services, String lang) async {
    final box = store.box<ServiceModel>();

    // Delete existing services for this language
    final existingServices =
        box.query(ServiceModel_.language.equals(lang)).build().find();
    box.removeMany(existingServices.map((e) => e.id).toList());

    // Store new services with downloaded images
    final serviceModels = await Future.wait(
        services.map((service) => ServiceModel.fromService(service, lang)));

    box.putMany(serviceModels);
  }
}
