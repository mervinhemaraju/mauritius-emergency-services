import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/providers/search_controller.dart';
import 'package:mauritius_emergency_services/providers/services_providers.dart';
import 'package:mauritius_emergency_services/routes/routes.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_search/search_view.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services_list.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services_provider.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services_state.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class ServicesScreen extends ConsumerWidget {
  final String searchQuery;

  const ServicesScreen({super.key, this.searchQuery = ""});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the global scaffold key
    final scaffoldKey = GlobalKey<ScaffoldState>();

    // Define a retry action
    retryAction() async {
      await ref.read(servicesProvider.notifier).refresh();
    }

    // Define the UI state
    final servicesUiState = ref
        .watch(servicesStateProvider)
        .when(
          error: (error, stack) => ServicesError(message: error.toString()),
          loading: () => const ServicesLoading(),
          data: (state) => state,
        );

    // Define the UI view
    final servicesUiView = switch (servicesUiState) {
      ServicesLoading() => const LoadingScreen(),
      ServicesError() => ErrorScreen(
        title: servicesUiState.message.capitalize(),
        showErrorImage: true,
        retryAction: retryAction,
      ),
      ServicesNoInternet() => ErrorScreen(
        title: servicesUiState.message.capitalize(),
        showInternetErrorImage: true,
        retryAction: retryAction,
      ),
      ServicesLoaded() => Column(
        spacing: 12.0,
        children: [
          Visibility(
            visible: searchQuery.isNotEmpty,
            child: ChoiceChip(
              label: Text("Filtering by: $searchQuery"),
              avatar: const Icon(Icons.close),
              showCheckmark: false,
              selected: true,
              selectedColor: Theme.of(context).colorScheme.secondaryContainer,
              labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              onSelected: (selection) {
                // Clear the search query
                ref.read(globalSearchControllerProvider.notifier).clear();

                // Navigate to the whole list of services
                context.go(ServicesRoute.path);
              },
            ),
          ),

          Expanded(
            child: ServicesList(
              services: servicesUiState.services.search(query: searchQuery),
            ),
          ),
        ],
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
