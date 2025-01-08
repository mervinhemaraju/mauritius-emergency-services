import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';

// The about header list item
class AboutHeaderListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color background;
  final Color foreground;
  final Function()? onTap;

  const AboutHeaderListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.background,
    required this.foreground,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: 28,
          color: foreground,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
      onTap: onTap,
    );
  }
}

// The about section list item
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
      leading: Icon(
        icon,
        color: theme.colorScheme.primary,
      ),
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

// The emergency tile items
class MesEmergencyTileItem extends StatelessWidget {
  final Service service;
  final VoidCallback onTap;

  const MesEmergencyTileItem({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 240,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                service.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FadeInImage.assetNetwork(
                  placeholder: AssetsManager.ANIMATED_LOADING,
                  image: service.icon,
                  width: 48,
                  height: 48,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
