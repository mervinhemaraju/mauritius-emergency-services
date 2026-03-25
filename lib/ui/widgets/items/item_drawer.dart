import 'package:flutter/material.dart';

// The MES Drawer Item
class MesDrawerItem extends StatelessWidget {
  final bool isSelected;
  final Icon leadingIcon;
  final String title;
  final void Function() onTap;
  final Widget? trailing;

  const MesDrawerItem({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(25), // Apply stadium effect
          left: Radius.zero, // No effect on the left
        ),
      ),
      onTap: onTap,
    );
  }
}

// The abo
