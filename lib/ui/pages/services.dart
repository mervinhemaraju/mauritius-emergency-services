import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/providers/search_controller.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/ui/components/appbar.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/screen_error.dart';
import 'package:mauritius_emergency_services/ui/components/screen_loading.dart';
import 'package:mauritius_emergency_services/ui/components/widgets.dart';

class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final List<Service> services = ref.watch(servicesProvider);
    final searchController = ref.watch(globalSearchControllerProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final uiState = ref.watch(servicesProvider).when(
        data: (services) => ServicesUi(services: services),
        loading: () => LoadingScreen(),
        error: (error, stack) => ErrorScreen(title: error.toString()));

    return Scaffold(
      key: scaffoldKey,
      appBar: MesAppSearchBar(
        searchController: searchController,
        openDrawer: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: MesDrawer(),
      body: uiState,
    );
  }
}

class ServicesUi extends StatelessWidget {
  const ServicesUi({
    super.key,
    required this.services,
  });

  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    // Sort the services by name
    services.sort((a, b) => a.name.compareTo(b.name));

    // Return the view
    return Padding(
      padding: const EdgeInsets.only(top: 26.0),
      child: ListView(
        children:
            services.map((service) => ServiceItem(service: service)).toList(),
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final Service service;

  const ServiceItem({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      leading: FadeInImage.assetNetwork(
        placeholder: AssetsManager.ANIMATED_LOADING,
        image: service.icon,
        width: 48,
        height: 48,
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(service.name),
      ),
      subtitle: Row(
        spacing: 8.0,
        children: [
          Text(service.mainContact.toString()),
          MesBadge(label: "Toll Free")
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.arrow_drop_down_outlined),
      ),
    );
  }
}
