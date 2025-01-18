import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/models/settings.dart';
import 'package:mauritius_emergency_services/core/providers/services_providers.dart';
import 'package:mauritius_emergency_services/core/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/gen/strings.g.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_search.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the scaffold key
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final homeUiState = ref.watch(emergencyServicesProvider).when(
          data: (services) {
            if (services.isEmpty) {
              return ErrorScreen(
                title: t.messages.error
                    .services_unavailable(
                      app_name_short: t.app.short_name.toUpperCase(),
                    )
                    .capitalize(),
                showErrorImage: true,
                retryAction: () =>
                    ref.refresh(emergencyServicesProvider.future),
              );
            } else {
              return _HomeUi(
                emergencyServices: services,
                settings: ref.read(mesSettingsNotifierProvider),
              );
            }
          },
          loading: () => const LoadingScreen(),
          error: (error, stack) => ErrorScreen(
            title: t.messages.error.cannot_load_data.capitalize(),
            showErrorImage: true,
            retryAction: () => ref.refresh(emergencyServicesProvider.future),
          ),
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
      body: homeUiState,
    );
  }
}

class _HomeUi extends ConsumerWidget {
  final List<Service> emergencyServices;
  final MesSettings settings;

  const _HomeUi({
    required this.emergencyServices,
    required this.settings,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TitleSet(
                theme: theme,
                title: t.pages.home.primary_title.capitalizeAll(),
                subtitle: t.pages.home.primary_subtitle.capitalize(),
              ),
              const SizedBox(height: 32.0),
              _EmergencyButton(
                theme: theme,
                onTap: null,
                onLongPress: () {
                  final Service emergencyService;

                  if (settings.emergencyButtonAction.identifier.isNotEmpty) {
                    emergencyService = settings.emergencyButtonAction;
                  } else {
                    emergencyService = emergencyServices.first;
                  }

                  context.navigateToPreCall(emergencyService,
                      emergencyService.mainContact.toString());
                },
              ),
              const SizedBox(height: 32.0),
              _TitleSet(
                theme: theme,
                title: t.pages.home.secondary_title.capitalizeAll(),
                subtitle: t.pages.home.secondary_subtitle.capitalize(),
              ),
              _EmergencyListView(
                onTap: (service) {
                  context.navigateToPreCall(
                      service, service.mainContact.toString());
                },
              ),
              const SizedBox(height: 8.0),
            ],
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
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
    required Function()? onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.error,
        fixedSize: const Size(200, 200),
        shape: const CircleBorder(),
      ),
      child: Icon(
        Icons.sensors_outlined,
        color: theme.colorScheme.onError,
        size: 32,
      ),
    );
  }

  Widget _EmergencyListView({required Function(Service) onTap}) {
    return SizedBox(
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
    );
  }
}
