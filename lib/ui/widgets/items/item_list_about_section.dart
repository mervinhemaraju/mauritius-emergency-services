import 'package:flutter/material.dart';

class AboutSectionListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Function() onTap;

  const AboutSectionListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      minVerticalPadding: 12.0,
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.secondary,
        ),
      ),
      onTap: onTap,
    );
  }
}
