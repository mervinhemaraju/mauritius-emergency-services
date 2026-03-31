/* 
* The MES Chip component
*/
import 'package:flutter/material.dart';

class MesChipSelectable extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final IconData? icon;
  final Function()? onTap;
  final bool selected;

  const MesChipSelectable({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16.0,
                color: selected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 4.0),
            ],
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: selected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
