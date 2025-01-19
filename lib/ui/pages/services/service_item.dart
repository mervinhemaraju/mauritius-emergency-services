import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';

class ServicesList extends StatefulWidget {
  final List<Service> services;

  const ServicesList({
    super.key,
    required this.services,
  });

  @override
  State<ServicesList> createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
  String? expandedId;
  Color? dismissibleBackgroundColor;

  void toggleExpansion(String identifier) {
    setState(() {
      expandedId = expandedId == identifier ? null : identifier;
    });
  }

  void toggleDismissibleBackgroundColor(Color color) {
    setState(() {
      dismissibleBackgroundColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.services.length,
      itemBuilder: (context, index) {
        final service = widget.services[index];
        return ExpandableDismissibleService(
          service: service,
          isExpanded: expandedId == service.identifier,
          dismissibleBackgroundColor: dismissibleBackgroundColor ??
              Theme.of(context).colorScheme.secondary,
          onToggle: () => toggleExpansion(service.identifier),
          toggleDismissibleBackgroundColor: (color) =>
              toggleDismissibleBackgroundColor(color),
        );
      },
    );
  }
}
