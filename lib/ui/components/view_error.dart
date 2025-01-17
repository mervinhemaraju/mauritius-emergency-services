import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';

class ErrorScreen extends StatelessWidget {
  // Global vars
  final String title;
  final bool showErrorImage;
  final Function()? retryAction;

  // Constructor
  const ErrorScreen({
    super.key,
    required this.title,
    this.retryAction,
    this.showErrorImage = false,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 32.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            spacing: 8.0,
            children: [
              if (showErrorImage)
                Image.asset(
                  AssetsManager.STATIC_ERROR,
                  width: 200,
                  height: 200,
                ),
              Text(
                "Ooops!",
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          if (retryAction != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton(
                onPressed: retryAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.tertiary,
                  foregroundColor: theme.colorScheme.onTertiary,
                ),
                child: const Text("Retry"),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
