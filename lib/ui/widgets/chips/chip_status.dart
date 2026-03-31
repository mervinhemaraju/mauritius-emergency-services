/* 
* The MES Chip component
*/
import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/ui/theme/shapes.dart';

class MesChipStatus extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData? icon;
  final Function()? onTap;

  const MesChipStatus({
    required this.label,
    super.key,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
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
          borderRadius: MesBorders.chip,
        ),
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16.0,
                color: foregroundColor ?? theme.colorScheme.onPrimary,
              ),
              const SizedBox(width: 4.0),
            ],
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: foregroundColor ?? theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
