import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/gen/strings.g.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logging/logging.dart';

// Initialize the logger
final Logger log = Logger('pre_call_views.dart');

class PreCallWideLeftView extends StatelessWidget {
  const PreCallWideLeftView({
    super.key,
    required this.service,
  });

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 21.0),
      child: Column(
        spacing: 48.0,
        children: [
          _HeaderView(service: service),
          _IconView(service: service),
        ],
      ),
    );
  }
}

class PreCallWideRightView extends StatelessWidget {
  const PreCallWideRightView({
    super.key,
    required this.service,
    required this.number,
    required this.onComplete,
  });

  final Service service;
  final String number;
  final void Function() onComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 21.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 16.0,
        children: [
          Text(t.pages.precall.calling_in.capitalize()),
          Expanded(
            child: Center(
              child: _CountdownTimer(
                onComplete: () async {
                  onCountdownComplete(
                    service: service,
                    number: number,
                    onComplete: onComplete,
                  );
                },
              ),
            ),
          ),
          _SlideToCancel(),
        ],
      ),
    );
  }
}

class PreCallNarrowView extends StatelessWidget {
  const PreCallNarrowView({
    super.key,
    required this.service,
    required this.number,
    required this.onComplete,
  });

  final Service service;
  final String number;
  final void Function() onComplete;

  @override
  Widget build(BuildContext context) {
    // Return the view
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 80.0,
        children: [
          _HeaderView(service: service),
          _IconView(service: service),
          _CountdownTimer(
            onComplete: () async {
              onCountdownComplete(
                service: service,
                number: number,
                onComplete: onComplete,
              );
            },
          ),
          _SlideToCancel(),
        ],
      ),
    );
  }
}

class _IconView extends StatelessWidget {
  const _IconView({
    required this.service,
  });

  final Service service;

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Expanded(
      child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.colorScheme.tertiary,
              width: 4.0,
            ),
          ),
          width: MediaQuery.sizeOf(context).width,
          child: service.iconData.loadImage(
            networkImageUrl: service.icon,
            memoryPlaceholderImage: AssetsManager.ANIMATED_LOADING,
            size: 60,
            fit: BoxFit.contain,
          )),
    );
  }
}

class _HeaderView extends StatelessWidget {
  const _HeaderView({
    required this.service,
  });
  final Service service;

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Column(
      children: [
        Text(
          t.pages.precall.title.capitalize(),
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Text(
          service.name,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Text(
          service.mainContact.toString(),
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w500,
            letterSpacing: 4.0,
          ),
        ),
      ],
    );
  }
}

class _SlideToCancel extends StatefulWidget {
  @override
  State<_SlideToCancel> createState() => _SlideToCancelState();
}

class _SlideToCancelState extends State<_SlideToCancel> {
  // Define variables
  bool isOverThreshold = false;

  @override
  Widget build(BuildContext context) {
    // Return the view
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        dismissThresholds: const {DismissDirection.endToStart: 0.5},
        background: _SlideToCancelBackBody(isOverThreshold: isOverThreshold),
        key: const Key("swipe_to_cancel"),
        // Provide a function that tells the app
        // what to do after an item has been swiped away.
        onDismissed: (direction) {
          context.goBack();
        },
        onUpdate: (details) {
          if (details.reached) {
            // You can adjust this threshold value
            // Update the background color to red
            setState(() {
              // Add a variable in your state to track the color
              isOverThreshold = true;
            });
          } else {
            setState(() {
              isOverThreshold = false;
            });
          }
        },
        child: const _SlideToCancelFrontBody(),
      ),
    );
  }
}

class _SlideToCancelBackBody extends StatelessWidget {
  final bool isOverThreshold;

  const _SlideToCancelBackBody({
    required this.isOverThreshold,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
      alignment: Alignment.centerRight,
      color: isOverThreshold
          ? theme.colorScheme.error
          : theme.colorScheme.secondary,
      child: Icon(
        isOverThreshold ? Icons.call_end_outlined : Icons.call_outlined,
        color: isOverThreshold
            ? theme.colorScheme.onError
            : theme.colorScheme.onSecondary,
      ),
    );
  }
}

class _SlideToCancelFrontBody extends StatelessWidget {
  const _SlideToCancelFrontBody();

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            t.actions.slide_to_cancel.capitalizeAll(),
            style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primaryContainer,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Transform.flip(
                flipX: true,
                child: const Icon(
                  Icons.double_arrow_outlined,
                  size: 48.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CountdownTimer extends StatefulWidget {
  final VoidCallback onComplete;

  const _CountdownTimer({required this.onComplete});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<_CountdownTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  int count = 3;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-1.5, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _startCountdown();
  }

  void _startCountdown() async {
    while (count > 0) {
      await Future.delayed(const Duration(milliseconds: 400));
      if (mounted) {
        setState(() {
          isAnimating = true;
        });
        await _controller.forward();
        if (mounted) {
          setState(() {
            count--;
            isAnimating = false;
          });
        }
        _controller.reset();
      }
    }
    widget.onComplete();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Text(
        '$count',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

void onCountdownComplete({
  required Service service,
  required String number,
  required Function() onComplete,
}) async {
  if (Platform.isAndroid) {
    // Define the data
    String numberUri = 'tel:$number';

    // Check if the number is an emergency number
    if (service.type.toUpperCase() == "E") {
      numberUri = 'tel:$number+';
    }

    // Build the android intent
    final AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.CALL',
      data: numberUri,
    );

    // Launch the intent
    await intent.launch();
  } else {
    // Build the URI
    final uri = Uri(
      scheme: 'tel',
      path: number,
    );

    // Launch the URL with explicit LaunchMode
    if (!await launchUrl(uri)) {
      // TODO(Add this to a snackbar or something)
      log.severe('Could not launch $uri');
    }
  }

  // Run on completion function
  onComplete();
}
