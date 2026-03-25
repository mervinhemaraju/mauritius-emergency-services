import 'package:flutter/material.dart';

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
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: Icon(Icons.person, size: 28, color: foreground),
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
