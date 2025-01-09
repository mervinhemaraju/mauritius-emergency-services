import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  // Global vars
  final String title;
  final Function()? retryAction;

  // Constructor
  const ErrorScreen({super.key, required this.title, this.retryAction});

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Ooops!",
          style: theme.textTheme.headlineLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (retryAction != null) ...[
          SizedBox(height: 34.0),
          ElevatedButton(
            onPressed: retryAction,
            style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: theme.colorScheme.onSecondary),
            child: Text("Retry"),
          ),
        ]
      ],
    );
  }
}
