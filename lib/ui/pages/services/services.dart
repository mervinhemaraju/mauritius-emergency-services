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

    // Watch the services ui state
    final servicesUiState = ref.watch(servicesProvider).when(
          data: (services) {
            if (services.isEmpty) {
              return ErrorScreen(
                title:
                    "Looks like no services are available. Make sure you are connected to the internet the first time for MES to download the services.",
                showErrorImage: true,
                retryAction: () => ref.refresh(servicesProvider.future),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child:
                    ServicesList(services: services.search(query: searchQuery)),
              );
            }
          },
          error: (error, stack) => ErrorScreen(
            title:
                "Looks like something went wrong and we couldn't load the services.",
            showErrorImage: true,
            retryAction: () => ref.refresh(servicesProvider.future),
          ),
          loading: () => const LoadingScreen(),
        );

    // Return the view
    return Scaffold(
      key: scaffoldKey,
      appBar: MesAppSearchBar(
        openDrawer: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: const MesDrawer(),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        onRefresh: () async => ref.refresh(servicesProvider.future),
        child: servicesUiState,
      ),
    );
  }
}
