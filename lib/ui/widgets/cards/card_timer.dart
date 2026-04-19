import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';

/*
* A timer card to display the time
*/
class TimerCard extends StatelessWidget {
  final String time;
  final String subtitle;

  const TimerCard({required this.time, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Card(
      elevation: MesElevation.card,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: theme.textTheme.displayMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              subtitle,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
