import 'package:flutter/material.dart';

/*
* The special header title component
*/
class SpecialHeaderTitle extends StatelessWidget {
  final String leadingCharacter;
  final String title;

  const SpecialHeaderTitle({
    required this.leadingCharacter,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
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
