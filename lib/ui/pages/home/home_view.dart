import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mauritius_emergency_services/core/models/service/service.dart';
import 'package:mauritius_emergency_services/data/remote/api/service/mes_service_provider.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_search/search_view.dart';
import 'package:mauritius_emergency_services/ui/components/views/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/views/view_loading.dart';
import 'package:mauritius_emergency_services/ui/pages/home/home_provider.dart';
import 'package:mauritius_emergency_services/ui/pages/home/home_state.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:mauritius_emergency_services/ui/widgets/drawers/drawer_primary.dart';
import 'package:mauritius_emergency_services/ui/widgets/items/item_service_emergency.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the scaffold key
    final scaffoldKey = GlobalKey<ScaffoldState>();

    // Define a retry action
    Future<void> retryAction() async {
      await ref.read(servicesProvider.notifier).refresh();
    }

    // Define the UI state
    final homeUiState = ref
        .watch(homeStateProvider)
        .when(
          error: (error, stack) => HomeError(message: error.toString()),
          loading: () => const HomeLoading(),
          data: (state) => state,
        );

    // Get the ui view
    final homeUiView = switch (homeUiState) {
      HomeLoading() => const LoadingScreen(),
      HomeError() => ErrorScreen(
        title: homeUiState.message.capitalize(),
        showErrorImage: true,
        retryAction: retryAction,
      ),
      HomeNoInternet() => ErrorScreen(
        title: homeUiState.message.capitalize(),
        showInternetErrorImage: true,
        retryAction: retryAction,
      ),
      HomeLoaded() => _HomeUi(
        emergencyServices: homeUiState.services,
        emergencyButtonAction: homeUiState.emergencyButtonAction,
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
      drawer: const MesDrawerPrimary(),
      body: homeUiView,
    );
  }
}

class _HomeUi extends ConsumerWidget {
  final List<MesService> emergencyServices;
  final MesService emergencyButtonAction;
  // final MesSettings settings;

  const _HomeUi({
    required this.emergencyServices,
    required this.emergencyButtonAction,
    // required this.settings,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Return the view
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Gap(16.0),
              _TitleSet(
                title: t.pages.home.primary_title.capitalizeAll(),
                subtitle: t.pages.home.primary_subtitle.capitalize(),
              ),
              const Spacer(),
              const Gap(32.0),
              _EmergencyButton(
                onTap: null,
                onLongPress: () {
                  final MesService emergencyService;

                  if (emergencyButtonAction.identifier.isNotEmpty) {
                    emergencyService = emergencyButtonAction;
                  } else {
                    emergencyService = emergencyServices.first;
                  }

                  context.navigateToPreCall(
                    emergencyService,
                    emergencyService.mainContact.toString(),
                  );
                },
              ),
              const Spacer(),
              const Gap(32.0),
              _TitleSet(
                title: t.pages.home.secondary_title.capitalizeAll(),
                subtitle: t.pages.home.secondary_subtitle.capitalize(),
              ),
              const Spacer(),
              const Gap(32.0),
              _EmergencyListView(
                emergencyServices: emergencyServices,
                onTap: (service) {
                  context.navigateToPreCall(
                    service,
                    service.mainContact.toString(),
                  );
                },
              ),
              const Spacer(),
              const Gap(16.0),
            ],
          ),
        ),
      ],
    );
  }
}

class _TitleSet extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TitleSet({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _EmergencyButton extends StatelessWidget {
  final Function() onLongPress;
  final Function()? onTap;

  const _EmergencyButton({
    required this.onLongPress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.error,
        fixedSize: const Size(230, 230),
        shape: const CircleBorder(),
      ),
      child: Icon(
        Icons.sensors_outlined,
        color: Theme.of(context).colorScheme.onError,
        size: 32,
      ),
    );
  }
}

class _EmergencyListView extends ConsumerWidget {
  final List<MesService> emergencyServices;
  final Function(MesService) onTap;

  const _EmergencyListView({
    required this.emergencyServices,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        prototypeItem: const MesEmergencyTileItem(
          service: MesService(),
          onTap: null,
        ),
        itemCount: emergencyServices.length,
        itemBuilder: (context, index) {
          return MesEmergencyTileItem(
            service: emergencyServices[index],
            onTap: () {
              onTap(emergencyServices[index]);
            },
          );
        },
      ),
    );
  }
}
