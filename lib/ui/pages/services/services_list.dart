import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/models/service.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services_provider.dart';

class ServicesList extends ConsumerWidget {
  final List<Service> services;

  const ServicesList({super.key, required this.services});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedId = ref.watch(expandedServiceStateProvider);
    final dismissibleBackgroundColor =
        ref.watch(dismissibleBackgroundColorStateProvider) ??
        Theme.of(context).colorScheme.secondary;

    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return ExpandableDismissibleService(
          service: service,
          isExpanded: expandedId == service.identifier,
          dismissibleBackgroundColor: dismissibleBackgroundColor,
          onToggle: () => ref
              .read(expandedServiceStateProvider.notifier)
              .toggleExpansion(service.identifier),
          toggleDismissibleBackgroundColor: (color) => ref
              .read(dismissibleBackgroundColorStateProvider.notifier)
              .setColor(color),
        );
      },
    );
  }
}
