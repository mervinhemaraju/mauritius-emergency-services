import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/ui/components/adaptive_screen.dart';
import 'package:mauritius_emergency_services/ui/pages/precall/precall_views.dart';

class PreCallScreen extends StatelessWidget {
  final Service service;
  final String number;
  final void Function() onComplete;

  const PreCallScreen({
    super.key,
    required this.service,
    required this.number,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: theme.colorScheme.primaryContainer,
        body: SafeArea(
          child: AdaptiveView(
            mobileView: PreCallNarrowView(
              service: service,
              number: number,
              onComplete: onComplete,
            ),
            tabletLeftView: PreCallWideLeftView(
              service: service,
            ),
            tabletRightView: PreCallWideRightView(
              service: service,
              number: number,
              onComplete: onComplete,
            ),
          ),
        ),
      ),
    );
  }
}
