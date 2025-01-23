import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/providers/services_providers.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_search.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services_list.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services_provider.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services_state.dart';
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

    // Define a retry action
    retryAction() async {
      await ref.read(servicesNotifierProvider.notifier).refresh();
    }

    // Define the UI state
    final servicesUiState = ref.watch(servicesStateProvider).when(
          error: (error, stack) => ServicesErrorState(error.toString()),
          loading: () => const ServicesLoadingState(),
          data: (state) => state,
        );

    // Define the UI view
    final servicesUiView = switch (servicesUiState) {
      ServicesLoadingState() => const LoadingScreen(),
      ServicesErrorState(message: final message) => ErrorScreen(
          title: message.capitalize(),
          showErrorImage: true,
          retryAction: retryAction,
        ),

      // TODO("Add a better UI for this")
      ServicesNoInternetState(message: final message) => ErrorScreen(
          title: message.capitalize(),
          showErrorImage: true,
          retryAction: retryAction,
        ),
      ServicesUiState(
        services: final services,
      ) =>
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ServicesList(
            services: services.search(query: searchQuery),
          ),
        ),
    };

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
        onRefresh: retryAction,
        child: servicesUiView,
      ),
    );
  }
}
