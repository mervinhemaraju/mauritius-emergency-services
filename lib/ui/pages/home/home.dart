import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/providers/search_controller.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
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
          data: (services) => _HomeUi(
            emergencyServices: services,
          ),
          loading: () => LoadingScreen(),
          error: (error, stack) => ErrorScreen(
            title: error.toString(),
          ),
        );

    return Scaffold(
      key: scaffoldKey,
      appBar: MesAppSearchBar(
        searchController: searchController,
        openDrawer: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: const MesDrawer(),
      body: uiState,
    );
  }
}

class _HomeUi extends StatelessWidget {
  final List<Service> emergencyServices;

  const _HomeUi({
    required this.emergencyServices,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Sort the emergency services by name
    emergencyServices.sort((a, b) => a.name.compareTo(b.name));

    // Return the view
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
                _TitleSet(
                  theme: theme,
                  title: "Emergency call help needed?",
                  subtitle: "Hold the emergency button to call",
                ),
                _EmergencyButton(
                  theme: theme,
                  onLongPress: () {
                    context.push(MesRoutes.precall);
                  },
                ),
                _TitleSet(
                  theme: theme,
                  title: "Need other quick emergency actions?",
                  subtitle: "Click one below to call",
                ),
                _EmergencyListView()
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _TitleSet({
    required ThemeData theme,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            subtitle,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget _EmergencyButton({
    required ThemeData theme,
    required Function() onLongPress,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ElevatedButton(
        onPressed: null,
        onLongPress: onLongPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.error,
          fixedSize: Size(200, 200),
          shape: CircleBorder(),
        ),
        child: Icon(
          Icons.sensors_outlined,
          color: theme.colorScheme.onError,
          size: 32,
        ),
      ),
    );
  }

  Widget _EmergencyListView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
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
    );
  }
}
