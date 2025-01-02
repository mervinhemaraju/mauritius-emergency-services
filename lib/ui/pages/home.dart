import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/providers/search_controller.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/ui/components/appbar.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/emergency_item.dart';
import 'package:mauritius_emergency_services/ui/components/screen_error.dart';
import 'package:mauritius_emergency_services/ui/components/screen_loading.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final searchController = ref.watch(globalSearchControllerProvider);
    final uiState = ref.watch(emergencyServicesProvider).when(
        data: (services) => HomeUi(
              emergencyServices: services,
            ),
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

class HomeUi extends StatelessWidget {
  const HomeUi({
    super.key,
    required this.emergencyServices,
  });
  final List<Service> emergencyServices;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    emergencyServices.sort((a, b) => a.name.compareTo(b.name));
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Text(
                      "Emergency call help needed?",
                      style: theme.textTheme.headlineSmall,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Hold the emergency button to call",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: null,
                  onLongPress: () {
                    print("Emergency button clicked!");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    fixedSize: Size(200, 200),
                    shape: CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.sensors_outlined,
                    color: Colors.white,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Need other quick emergency actions?",
                        style: theme.textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Click one below to call",
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: SizedBox(
                        height: 180,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: emergencyServices
                              .map(
                                (service) => MesEmergencyItem(service: service),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
