import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/datasources.dart';
import 'package:mauritius_emergency_services/data/repositories.dart';

const List<Service> services = [
  Service(
    identifier: "police",
    name: "Police",
    icon: "https://img.icons8.com/fluent/100/000000/policeman-male.png",
    type: "E",
    emails: [],
    mainContact: 999,
    otherContacts: [],
  ),
  Service(
    identifier: "health-samu",
    name: "Samu",
    type: "E",
    icon: "https://img.icons8.com/bubbles/100/000000/ambulance.png",
    mainContact: 114,
    emails: [],
    otherContacts: [],
  ),
  Service(
    identifier: "health-ccare-ambulance",
    name: "C-Care Ambulance",
    type: "E",
    icon: "https://img.icons8.com/bubbles/100/000000/ambulance.png",
    mainContact: 118,
    emails: [],
    otherContacts: [132],
  ),
  Service(
      identifier: "security-police-tourism",
      name: "Tourism Police",
      type: "N",
      icon: "https://img.icons8.com/fluent/100/000000/policeman-male.png",
      mainContact: 2131740,
      emails: [],
      otherContacts: []),
  Service(
    identifier: "security-rescue-fire",
    name: "Fire Rescue Services",
    type: "E",
    icon: "https://img.icons8.com/bubbles/100/000000/fire-element.png",
    mainContact: 115,
    emails: [],
    otherContacts: [995, 2120214, 2120215],
  ),
];

final dioProvider = Provider((ref) => Dio());

final servicesRepositoryProvider = Provider<MesRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final dataSource = MesRemoteDataSource(dio);
  return MesRepositoryImpl(dataSource);
});

final servicesProvider = FutureProvider<List<Service>>((ref) async {
  final repository = ref.watch(servicesRepositoryProvider);
  return repository.getServices();
});

final emergencyServicesProvider = FutureProvider<List<Service>>((ref) async {
  final services = await ref.watch(servicesProvider.future);
  return services.where((service) => service.type == "E").toList();
});
