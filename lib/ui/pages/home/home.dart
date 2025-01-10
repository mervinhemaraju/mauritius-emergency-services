import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/models/settings.dart';
import 'package:mauritius_emergency_services/core/providers/search_controller.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/ui/components/appbar.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mauritius_emergency_services/ui/pages/welcome/perms.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the scaffold key
    final scaffoldKey = GlobalKey<ScaffoldState>();

    // Get the settings
    final settings = ref.watch(settingsProvider);

    // Get the search controller
    final searchController = ref.watch(globalSearchControllerProvider);

    // Watch the services and define the ui
    final uiState = ref.watch(emergencyServicesProvider).when(
          data: (services) => _HomeUi(
            emergencyServices: services,
            settings: settings,
          ),
          loading: () => LoadingScreen(),
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
      drawer: const MesDrawer(),
      body: uiState,
    );
  }
}

class _HomeUi extends StatelessWidget {
  final List<Service> emergencyServices;
  final MesSettings settings;

  const _HomeUi({
    required this.emergencyServices,
    required this.settings,
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
                  title: AppLocalizations.of(context)!.title_home_primary,
                  subtitle: "Hold the emergency button to call",
                ),
                _EmergencyButton(
                  theme: theme,
                  onLongPress: () {
                    final Service emergencyService;

                    if (settings.emergencyButtonAction.identifier.isNotEmpty) {
                      emergencyService = settings.emergencyButtonAction;
                    } else {
                      emergencyService = emergencyServices.first;
                    }

                    context.push(
                      PrecallRoute.path,
                      extra: {PrecallRoute.extraService: emergencyService},
                    );
                  },
                ),
                _TitleSet(
                  theme: theme,
                  title: "Need other quick emergency actions?",
                  subtitle: "Click one below to call",
                ),
                _EmergencyListView(onTap: (service) {
                  context.push(PrecallRoute.path, extra: {
                    PrecallRoute.extraService: service,
                  });
                })
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
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w400,
            ),
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

  Widget _EmergencyListView({required Function(Service) onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        height: 180,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: emergencyServices
              .map(
                (service) => MesEmergencyTileItem(
                  service: service,
                  onTap: () {
                    onTap(service);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
