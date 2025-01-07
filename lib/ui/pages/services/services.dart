import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/providers/search_controller.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/ui/components/appbar.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/screen_error.dart';
import 'package:mauritius_emergency_services/ui/components/screen_loading.dart';
import 'package:mauritius_emergency_services/ui/pages/services/service_item.dart';

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
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        onRefresh: () async => ref.refresh(servicesProvider.future),
        child: uiState,
      ),
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
    return ServicesList(services: services);
  }
}
