import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';

class PreCallScreen extends StatefulWidget {
  const PreCallScreen({super.key});

  @override
  State<PreCallScreen> createState() => PreCallScreenState();
}

class PreCallScreenState extends State<PreCallScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var dimissibleBackgroundColor = theme.colorScheme.secondary;

    return Scaffold(
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
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Dismissible(
                  direction: DismissDirection.endToStart,
                  dismissThresholds: {DismissDirection.endToStart: 0.6},
                  background: Container(
                    padding: EdgeInsets.all(16.0),
                    alignment: Alignment.centerRight,
                    color: dimissibleBackgroundColor,
                    child: Icon(Icons.call_end_outlined),
                  ),
                  key: Key("unique"),
                  // Provide a function that tells the app
                  // what to do after an item has been swiped away.
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    // setState(() {
                    //   items.removeAt(index);
                    // });
                  },
                  onUpdate: (details) {
                    if (details.reached) {
                      print("REACHED");
                      // FIXME(backgroudn color not updating)
                      setState(() {
                        dimissibleBackgroundColor = theme.colorScheme.error;
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
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 36.0,
                              horizontal: 12.0,
                            ),
                            child: Transform.flip(
                              flipX: true,
                              child: const Icon(Icons.double_arrow_outlined),
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
    );
  }
}
