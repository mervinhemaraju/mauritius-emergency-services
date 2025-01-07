import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/ui/components/widgets.dart';

class ExpandableDismissibleTile extends StatefulWidget {
  final Service service;

  const ExpandableDismissibleTile({
    super.key,
    required this.service,
  });

  @override
  State<ExpandableDismissibleTile> createState() =>
      _ExpandableDismissibleTileState();
}

class _ExpandableDismissibleTileState extends State<ExpandableDismissibleTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.service.identifier),
      direction: DismissDirection.endToStart,
      dismissThresholds: const {DismissDirection.endToStart: 0.5},
      background: Container(
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 21.0),
          child: Icon(
            Icons.call_outlined,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            leading: FadeInImage.assetNetwork(
              placeholder: AssetsManager.ANIMATED_LOADING,
              image: widget.service.icon,
              width: 48,
              height: 48,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(widget.service.name),
            ),
            subtitle: Row(
              children: [
                Text(widget.service.mainContact.toString()),
                const SizedBox(width: 8.0),
                const MesBadge(label: "Toll Free")
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              icon: Icon(
                isExpanded
                    ? Icons.arrow_drop_up_outlined
                    : Icons.arrow_drop_down_outlined,
              ),
            ),
          ),
          // Animated container for smooth expansion/collapse
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: isExpanded ? 50.0 : 0.0,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Text('Additional information goes here'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
