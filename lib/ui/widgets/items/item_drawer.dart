import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/ui/theme/shapes.dart';

// The MES Drawer Item
class MesDrawerItem extends StatelessWidget {
  final bool isSelected;
  final Icon leadingIcon;
  final String title;
  final void Function() onTap;
  final Widget? trailing;

  const MesDrawerItem({
    required this.leadingIcon,
    required this.title,
    required this.onTap,
    super.key,
    this.trailing,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
      leading: leadingIcon,
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      trailing: trailing,
      shape: MesShapes.drawerItem,
      onTap: onTap,
    );
  }
}

// The abo
