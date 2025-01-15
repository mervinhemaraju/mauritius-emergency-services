import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/welcome.dart';
import 'package:mauritius_emergency_services/core/providers/settings.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/ui/components/adaptive_screen.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';
import 'package:mauritius_emergency_services/ui/pages/welcome/permissions_dialog.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';
import 'package:mauritius_emergency_services/ui/utils/getters.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the theme
    final theme = Theme.of(context);

    // Determine the background color
    final backgroundColor = theme.colorScheme.surface;

    // Return the view
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getSystemUiOverlayStyle(MediaQuery.platformBrightnessOf(context)),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: AdaptiveView(
            mobileView: _NarrowScreenUi(),
            tabletLeftView: _WideViewLeft(),
            tabletRightView: _WideViewRight(),
          ),
        ),
      ),
    );
  }
}

class _WideViewLeft extends StatelessWidget {
  const _WideViewLeft();

  @override
  Widget build(BuildContext context) {
    // Get the theme
    final theme = Theme.of(context);

    // Return the view
    return _WelcomeCarouselWithIndicator(
      backgroundColor: theme.colorScheme.surface,
      isNarrowUi: false,
    );
  }
}

class _WideViewRight extends ConsumerWidget {
  const _WideViewRight();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the theme
    final theme = Theme.of(context);

    // Return the view
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16.0,
      children: [
        SizedBox(),
        Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          runSpacing: 8.0,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Welcome to",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Mauritius Emergency Services",
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 4.0,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.0,
          children: [
            Icon(
              Icons.health_and_safety,
              color: theme.colorScheme.secondary,
              size: 36,
            ),
            Icon(
              Icons.storm,
              color: theme.colorScheme.secondary,
              size: 36,
            ),
            Icon(
              Icons.local_hospital,
              color: theme.colorScheme.secondary,
              size: 36,
            ),
            Icon(
              Icons.emergency,
              color: theme.colorScheme.secondary,
              size: 36,
            )
          ],
        ),
        MaterialButton(
          onPressed: () {
            _onNavigate(context, ref);
          },
          elevation: MesElevation.button,
          color: theme.colorScheme.primary,
          textColor: theme.colorScheme.onPrimary,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 12.0,
            children: [
              SizedBox(
                width: 12.0,
              ),
              Text("Get Started"),
              Icon(Icons.arrow_forward_ios_outlined)
            ],
          ),
        )
      ],
    );
  }
}

class _NarrowScreenUi extends StatelessWidget {
  const _NarrowScreenUi();

  @override
  Widget build(BuildContext context) {
    // Get the theme
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Mauritius Emergency Services",
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 3.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: _WelcomeCarouselWithIndicator(
            backgroundColor: theme.colorScheme.surface,
            isNarrowUi: true,
          ),
        ),
      ],
    );
  }
}

class _WelcomeCarouselWithIndicator extends ConsumerStatefulWidget {
  final Color backgroundColor;
  final bool isNarrowUi;
  const _WelcomeCarouselWithIndicator({
    required this.backgroundColor,
    required this.isNarrowUi,
  });

  @override
  ConsumerState<_WelcomeCarouselWithIndicator> createState() =>
      _WelcomeCarouselWithIndicatorState();
}

class _WelcomeCarouselWithIndicatorState
    extends ConsumerState<_WelcomeCarouselWithIndicator> {
  int currentIndex = 0;
  final carouselController = CarouselController();
  late double? maxWidth;

  @override
  void initState() {
    super.initState();
    carouselController.addListener(() {
      final position = carouselController.position;
      final width = (maxWidth ?? MediaQuery.sizeOf(context).width) - 32;
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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      maxWidth = constraints.maxWidth;

      return widget.isNarrowUi
          ? _build1(constraints.maxWidth)
          : _build2(constraints.maxWidth);
    });
  }

  Widget _build1(double shrinkExtent) {
    return Column(
      children: [
        _WelcomeCarouselView(
          carouselController: carouselController,
          shrinkExtent: shrinkExtent,
        ),
        _WideViewNavigator(currentIndex: currentIndex),
      ],
    );
  }

  Widget _build2(double shrinkExtent) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _WelcomeCarouselView(
          carouselController: carouselController,
          shrinkExtent: shrinkExtent,
        ),
        _CarouselIndicator(currentIndex: currentIndex),
      ],
    );
  }
}

class _WelcomeCarouselView extends StatelessWidget {
  const _WelcomeCarouselView({
    required this.shrinkExtent,
    required this.carouselController,
  });

  final double shrinkExtent;
  final CarouselController carouselController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselView(
        enableSplash: false,
        controller: carouselController,
        itemExtent: MediaQuery.sizeOf(context).width,
        itemSnapping: true,
        shrinkExtent: shrinkExtent,
        children: Welcome.welcomeItems
            .map(
              (item) => WelcomeCarouselItem(
                asset: item.asset,
                title: item.title,
                subtitle: item.subtitle,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CarouselIndicator extends StatelessWidget {
  const _CarouselIndicator({
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
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
    );
  }
}

class _WideViewNavigator extends ConsumerWidget {
  const _WideViewNavigator({
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _CarouselIndicator(currentIndex: currentIndex),
          const Spacer(),
          FloatingActionButton(
            elevation: MesElevation.fab,
            onPressed: () {
              _onNavigate(context, ref);
            },
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: const CircleBorder(),
            child: const Icon(Icons.arrow_forward_ios_outlined),
          ),
        ],
      ),
    );
  }
}

void _onNavigate(BuildContext context, WidgetRef ref) {
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
}
