import 'package:flutter/material.dart';

class MesBadge extends StatelessWidget {
  final String label;

  const MesBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Badge(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      label: Text(label),
      textColor: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}

class SpecialHeaderTitle extends StatelessWidget {
  final String leadingCharacter;
  final String title;
  const SpecialHeaderTitle(
      {super.key, required this.leadingCharacter, required this.title});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: leadingCharacter, // The first letter
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 4.0),
          ),
          TextSpan(
            text: title, // The rest of the text
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(letterSpacing: 4.0),
          ),
        ],
      ),
    );
  }
}
