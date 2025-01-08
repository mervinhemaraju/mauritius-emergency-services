import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';

class EmergencyButtonDialog extends ConsumerStatefulWidget {
  const EmergencyButtonDialog({super.key});

  @override
  ConsumerState<EmergencyButtonDialog> createState() =>
      EmergencyButtonDialogState();
}

class EmergencyButtonDialogState extends ConsumerState<EmergencyButtonDialog> {
  @override
  Widget build(BuildContext context) {
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
          loading: () => CircularProgressIndicator(),
          error: (error, stack) => Text("Error occurred"),
        );

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Emergency Button Action",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
            ),
            uiState,
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 21.0,
                ),
                child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text("Close")),
              ),
            )
          ],
        ),
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
    return Flexible(
      child: ListView(
        shrinkWrap: true,
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
      ),
    );
  }
}
