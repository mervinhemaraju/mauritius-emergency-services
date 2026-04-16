import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service/service.dart';
import 'package:mauritius_emergency_services/ui/pages/services/services_provider.dart';
import 'package:mauritius_emergency_services/ui/widgets/items/item_expandable_dismissable_service.dart';

class ServicesList extends ConsumerWidget {
  final List<MesService> services;

  const ServicesList({required this.services, super.key});

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
          toggleDismissibleBackgroundColor: (color) =>
              ref.read(dismissibleBackgroundColorStateProvider.notifier).color =
                  color,
        );
      },
    );
  }
}
