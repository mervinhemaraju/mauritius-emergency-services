import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/welcome.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';
import 'package:mauritius_emergency_services/ui/pages/welcome/permissions_dialog.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.surface;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32.0),
            Text(
              "Mauritius Emergency Services",
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: _WelcomeCarouselWithIndicator(
                backgroundColor: backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Stateful carousel component that provides currentIndex
class _WelcomeCarouselWithIndicator extends ConsumerStatefulWidget {
  final Color backgroundColor;

  const _WelcomeCarouselWithIndicator({
    required this.backgroundColor,
  });

  @override
  ConsumerState<_WelcomeCarouselWithIndicator> createState() =>
      _WelcomeCarouselWithIndicatorState();
}

class _WelcomeCarouselWithIndicatorState
    extends ConsumerState<_WelcomeCarouselWithIndicator> {
  int currentIndex = 0;
  final carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    carouselController.addListener(() {
      final position = carouselController.position;
      final width = MediaQuery.sizeOf(context).width - 32;
      if (position.hasPixels) {
        final index = (position.pixels / width).round();
        setState(() {
          currentIndex = index;
        });
      }
    });
  }

  @override
  void dispose() {
    carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: CarouselView(
            backgroundColor: widget.backgroundColor,
            controller: carouselController,
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            itemExtent: MediaQuery.sizeOf(context).width,
            itemSnapping: true,
            shrinkExtent: MediaQuery.sizeOf(context).width,
            children: Welcome.welcomeItems
                .map((item) => WelcomeCarouselItem(
                      asset: item.asset,
                      title: item.title,
                      subtitle: item.subtitle,
                    ))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: currentIndex == index ? 24 : 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: theme.colorScheme.secondary,
                    ),
                  );
                }),
              ),
              const Spacer(),
              FloatingActionButton(
                elevation: MesElevation.fab,
                onPressed: () {
                  // If this is IOS, we don't need to request explicit
                  // permissions for phone calls

                  // TODO : Improve the way permissions are handled -> Proposal below:
                  // Verify if phone permissions are granted in pre-call page instead on each page
                  // Notify users right away when they try to make a call.
                  // We can control this permission by asking just for android since no explicit permissions needed for IOS
                  // We can then have a simple way of telling users that they didn't grant permissions every time they open the app
                  if (Platform.isIOS) {
                    // Mark the user as onboarded
                    ref.read(settingsProvider.notifier).markAsOnboarded();

                    // Navigate to the home screen
                    context.go(HomeRoute.path);
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => PermissionsDialog(),
                    );
                  }
                },
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: const CircleBorder(),
                child: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
