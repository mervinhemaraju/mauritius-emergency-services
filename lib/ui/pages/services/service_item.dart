import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/ui/components/widgets.dart';

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
        return ExpandableDismissibleTile(
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

class ExpandableDismissibleTile extends StatelessWidget {
  final Service service;
  final bool isExpanded;
  final Color dismissibleBackgroundColor;
  final VoidCallback onToggle;
  final Function(Color) toggleDismissibleBackgroundColor;

  const ExpandableDismissibleTile({
    super.key,
    required this.service,
    required this.dismissibleBackgroundColor,
    required this.isExpanded,
    required this.onToggle,
    required this.toggleDismissibleBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(service.identifier),
      confirmDismiss: (direction) async {
        context.push(PrecallRoute.path, extra: {
          PrecallRoute.extraService: service,
        });
        return false;
      },
      onUpdate: (details) => {
        if (details.reached)
          {
            print("Reached threshold"),
            toggleDismissibleBackgroundColor(
                Theme.of(context).colorScheme.primary)
          }
        else
          {
            toggleDismissibleBackgroundColor(
                Theme.of(context).colorScheme.secondary)
          }
      },
      direction: DismissDirection.endToStart,
      dismissThresholds: const {DismissDirection.endToStart: 0.5},
      background: Container(
        alignment: Alignment.centerRight,
        color: dismissibleBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 21.0),
          child: Icon(
            Icons.call_outlined,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
      child: Container(
        color: isExpanded
            ? Theme.of(context).colorScheme.surfaceContainerHigh
            : Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              leading: FadeInImage.assetNetwork(
                placeholder: AssetsManager.ANIMATED_LOADING,
                image: service.icon,
                width: 48,
                height: 48,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(service.name),
              ),
              subtitle: Row(
                children: [
                  Text(service.mainContact.toString()),
                  const SizedBox(width: 8.0),
                  const MesBadge(label: "Toll Free")
                ],
              ),
              trailing: IconButton(
                onPressed: onToggle,
                icon: Icon(
                  isExpanded
                      ? Icons.arrow_drop_up_outlined
                      : Icons.arrow_drop_down_outlined,
                ),
              ),
              onTap: onToggle,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: isExpanded ? 50.0 : 0.0,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: const Text('Additional information goes here'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
