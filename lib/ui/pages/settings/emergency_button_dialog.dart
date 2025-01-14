import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/providers/services_providers.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';

class EmergencyButtonDialog extends ConsumerWidget {
  const EmergencyButtonDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final uiState = ref.watch(servicesProvider).when(
          data: (services) => ServiceListView(
            services: services,
            selectedService: settings.emergencyButtonAction,
            onServiceSelected: (service) {
              ref
                  .read(settingsProvider.notifier)
                  .updateEmergencyButtonAction(service);
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => ErrorScreen(
            title: "Couldn't load services",
            retryAction: () => ref.refresh(servicesProvider.future),
          ),
        );

    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        alignment: Alignment.center,
        child: Text("Choose Emergency Action"),
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: uiState,
      ),
    );
  }
}

class ServiceListView extends StatelessWidget {
  final List<Service> services;
  final Service selectedService;
  final Function(Service) onServiceSelected;

  const ServiceListView({
    super.key,
    required this.services,
    required this.selectedService,
    required this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: services
          .map(
            (service) => ListTile(
              selected: service.identifier == selectedService.identifier,
              selectedColor: Theme.of(context).colorScheme.onTertiary,
              selectedTileColor: Theme.of(context).colorScheme.tertiary,
              title: Text(service.name),
              subtitle: Text(service.mainContact.toString()),
              trailing: service.identifier == selectedService.identifier
                  ? Icon(
                      Icons.check_outlined,
                      color: Theme.of(context).colorScheme.onTertiary,
                    )
                  : null,
              onTap: () {
                onServiceSelected(service);
              },
            ),
          )
          .toList(),
    );
  }
}
