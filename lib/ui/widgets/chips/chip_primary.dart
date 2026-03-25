/* 
* The MES Chip component
*/
import 'package:flutter/material.dart';

class MesChipPrimary extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final IconData? icon;
  final Function()? onTap;

  const MesChipPrimary({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
    this.onTap,
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
          color: backgroundColor ?? theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16.0, color: theme.colorScheme.onPrimary),
              const SizedBox(width: 4.0),
            ],
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
