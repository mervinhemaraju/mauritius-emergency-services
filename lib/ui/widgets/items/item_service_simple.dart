import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/service/service.dart';

class SimpleServiceItem extends StatelessWidget {
  const SimpleServiceItem({
    required this.isSelected,
    required this.service,
    required this.onServiceSelected,
    super.key,
  });

  final bool isSelected;
  final MesService service;
  final Function(MesService service) onServiceSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      selectedColor: Theme.of(context).colorScheme.onTertiary,
      selectedTileColor: Theme.of(context).colorScheme.tertiary,
      title: Text(service.name),
      subtitle: Text(service.mainContact.toString()),
      trailing: isSelected
          ? Icon(
              Icons.check_outlined,
              color: Theme.of(context).colorScheme.onTertiary,
            )
          : null,
      onTap: () {
        onServiceSelected(service);
      },
    );
  }
}
