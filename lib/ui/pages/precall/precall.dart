import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class PreCallScreen extends StatelessWidget {
  final Service service;

  const PreCallScreen({
    super.key,
    required this.service,
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Text(
                      "Starting a call to",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      service.name,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    SizedBox(
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
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.tertiary,
                      width: 4.0,
                    ),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: AssetsManager.ANIMATED_LOADING,
                    image: service.icon,
                    width: 120,
                    height: 120,
                  ),
                ),
                _CountdownTimer(
                  onComplete: () {
                    // Add your action here
                    print('Countdown complete!');
                  },
                ),
                _SlideToCancel(),
              ],
            ),
          ),
        ),
      ),
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
        dismissThresholds: {DismissDirection.endToStart: 0.5},
        background: _SlideToCancelBackBody(isOverThreshold: isOverThreshold),
        key: Key("swipe_to_cancel"),
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
        child: _SlideToCancelFrontBody(),
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
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
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
            "Slide to Cancel",
            style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primaryContainer,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(12.0),
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
