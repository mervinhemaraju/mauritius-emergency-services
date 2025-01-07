import 'package:flutter/material.dart';

/* 
* The MES badge component
*/
class MesBadge extends StatelessWidget {
  final String label;

  const MesBadge({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onPrimary,
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
