import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/providers/notifiers/search_controller.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/ui/components/appbar.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';
import 'package:mauritius_emergency_services/ui/pages/services/service_item.dart';

class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the search controller from provider
    final searchController = ref.watch(globalSearchControllerProvider);

    // Get the global scaffold key
    final scaffoldKey = GlobalKey<ScaffoldState>();

    // Get the permitted service provider
    final servicesUiState = ref.watch(servicesProvider).when(
          data: (services) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ServicesList(services: services),
            );
          },
          loading: () => LoadingScreen(),

          // FIXME(Improve error screen content and add retry action)
          error: (error, stack) => ErrorScreen(
            title: error.toString(),
          ),
        );

    // Return the view
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
        child: servicesUiState,
      ),
    );
  }
}
