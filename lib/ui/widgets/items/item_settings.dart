import 'package:flutter/material.dart';

// The settings list item
class SettingsItem extends StatelessWidget {
  final IconData icon;
  final Widget? trailing;
  final String title;
  final String subtitle;
  final Function()? onTap;

  const SettingsItem({
    super.key,
    this.trailing,
    this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
