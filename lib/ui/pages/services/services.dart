import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/providers/services_providers.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_search.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';
import 'package:mauritius_emergency_services/ui/pages/services/service_item.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class ServicesScreen extends ConsumerWidget {
  final String searchQuery;

  const ServicesScreen({
    super.key,
    this.searchQuery = "",
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the global scaffold key
    final scaffoldKey = GlobalKey<ScaffoldState>();

    print("The query is $searchQuery");

    // Watch the services ui state
    final servicesUiState = ref.watch(servicesProvider).when(
          data: (services) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ServicesList(services: services.search(query: searchQuery)),
          ),
          error: (error, stack) => ErrorScreen(
            title:
                "Looks like something went wrong and we couldn't load the services.",
            showErrorImage: true,
            retryAction: () => ref.refresh(servicesProvider.future),
          ),
          loading: () => LoadingScreen(),
        );

    // Return the view
    return Scaffold(
      key: scaffoldKey,
      appBar: MesAppSearchBar(
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
