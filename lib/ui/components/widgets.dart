import 'package:flutter/material.dart';

/* 
* The MES Chip component
*/
class MesChip extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final IconData? icon;
  final Function()? onTap;

  const MesChip({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 6.0,
      vertical: 4.0,
    ),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              Icon(
                icon,
                size: 16.0,
                color: theme.colorScheme.onPrimary,
              ),
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

/*
* The special header title component
*/
class SpecialHeaderTitle extends StatelessWidget {
  final String leadingCharacter;
  final String title;

  const SpecialHeaderTitle({
    super.key,
    required this.leadingCharacter,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: leadingCharacter, // The first letter
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 4.0,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          TextSpan(
            text: title, // The rest of the text
            style: theme.textTheme.headlineSmall?.copyWith(
              letterSpacing: 4.0,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
