import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/providers/services_providers.dart';
import 'package:mauritius_emergency_services/core/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/gen/strings.g.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class EmergencyButtonDialog extends ConsumerWidget {
  const EmergencyButtonDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emergencyButtonAction = ref.watch(
      mesSettingsNotifierProvider.select((s) => s.emergencyButtonAction),
    );
    final uiState = ref.watch(servicesProvider).when(
          data: (services) => ServiceListView(
            services: services,
            selectedService: emergencyButtonAction,
            onServiceSelected: (service) {
              ref
                  .read(mesSettingsNotifierProvider.notifier)
                  .updateEmergencyButtonAction(service);
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => ErrorScreen(
            title: t.messages.error.cannot_load_data.capitalize(),
            retryAction: () => ref.refresh(servicesProvider.future),
          ),
        );

    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        alignment: Alignment.center,
        child: Text(
          t.pages.settings.section_feature.emergency_button_action.sheet_title
              .capitalizeAll(),
        ),
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
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      prototypeItem: SimpleServiceItem(
        isSelected: false,
        service: const Service(),
        onServiceSelected: onServiceSelected,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return SimpleServiceItem(
          isSelected: service.identifier == selectedService.identifier,
          service: service,
          onServiceSelected: onServiceSelected,
        );
      },
    );
  }
}
