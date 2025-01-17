import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/models/db/service_model.dart';
import 'package:mauritius_emergency_services/data/sources/mes.dart';
import 'package:mauritius_emergency_services/objectbox.g.dart';

// Create a local data source implementation
class MesServiceLocalDataSource implements MesDataSource {
  final Store store;

  MesServiceLocalDataSource(this.store);

  @override
  Future<List<Service>> getAllServices(String lang) async {
    print("Getting services locally");
    final box = store.box<ServiceModel>();
    final services =
        box.query(ServiceModel_.language.equals(lang)).build().find();

    print("Found ${services.length} services");
    for (var service in services) {
      print(
          "Service ${service.identifier} iconData length: ${service.iconData?.length}");
    }

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

    print("Storing ${serviceModels.length} services");
    print(
        "First service iconData length: ${serviceModels[0].iconData?.length}");

    box.putMany(serviceModels);

    // Verify storage
    final storedServices = box.getAll();
    print("Stored services count: ${storedServices.length}");
    print(
        "First stored service iconData length: ${storedServices[0].iconData?.length}");
  }
}
