import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/ui/settings/extensions.dart';

class PreCallScreen extends StatefulWidget {
  const PreCallScreen({super.key});

  @override
  State<PreCallScreen> createState() => PreCallScreenState();
}

class PreCallScreenState extends State<PreCallScreen> {
  bool isOverThreshold = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                    Text(
                      "Police Direct",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    Text(
                      "999",
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
                    image:
                        "https://img.icons8.com/fluent/100/000000/policeman-male.png",
                    width: 120,
                    height: 120,
                  ),
                ),
                Text(
                  "3",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    dismissThresholds: {DismissDirection.endToStart: 0.5},
                    background: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 32.0),
                      alignment: Alignment.centerRight,
                      color: isOverThreshold
                          ? theme.colorScheme.error
                          : theme.colorScheme.secondary,
                      child: Icon(
                        isOverThreshold
                            ? Icons.call_end_outlined
                            : Icons.call_outlined,
                        color: isOverThreshold
                            ? theme.colorScheme.onError
                            : theme.colorScheme.onSecondary,
                      ),
                    ),
                    key: Key("unique"),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimaryContainer,
                        // borderRadius: BorderRadius.circular(16.0),
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
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
