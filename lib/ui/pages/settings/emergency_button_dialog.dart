import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';

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
          loading: () => const CircularProgressIndicator(),

          // FIXME(Improve error screen content and add retry action)
          error: (error, stack) => const Text("Error occurred"),
        );

    return AlertDialog(
      title: Text(
        "Choose Emergency Action",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      contentPadding: EdgeInsets.zero, // Remove default padding
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
                      Icons.check_circle,
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
