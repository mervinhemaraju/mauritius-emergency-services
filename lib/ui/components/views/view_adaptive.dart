import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

class AdaptiveView extends StatelessWidget {
  final Widget mobileView;
  final Widget tabletLeftView;
  final Widget tabletRightView;

  const AdaptiveView({
    super.key,
    required this.mobileView,
    required this.tabletLeftView,
    required this.tabletRightView,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    final isWideView = MediaQuery.of(context).size.width >= 600.0;

    // Returns the mobile UI if the width is narrow.
    // Else it returns a splitview for table UI.
    return !isWideView
        ? mobileView
        : SplitView(
            viewMode: SplitViewMode.Horizontal,
            gripSize: 0.0,
            children: [
              tabletLeftView,
              tabletRightView,
            ],
          );
  }
}
