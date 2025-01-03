import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_report.dart';
import 'package:mauritius_emergency_services/core/providers/search_controller.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/ui/components/appbar.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/screen_error.dart';
import 'package:mauritius_emergency_services/ui/components/screen_loading.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';

class RotatingSvg extends StatefulWidget {
  final int level; // Define the variable

  const RotatingSvg({
    super.key,
    required this.level, // Add it to the constructor
  });

  @override
  _RotatingSvgState createState() => _RotatingSvgState();
}

class _RotatingSvgState extends State<RotatingSvg>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Duration _getDurationFromLevel() {
    switch (widget.level) {
      case 1:
        return const Duration(seconds: 7); // Slowest
      case 2:
        return const Duration(seconds: 4);
      case 3:
        return const Duration(seconds: 2);
      case 4:
        return const Duration(seconds: 1); // Fastest
      default:
        return const Duration(seconds: 7); // Default speed
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _getDurationFromLevel(), // Adjust rotation speed here
      vsync: this,
    )..repeat(); // This makes it rotate indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi, // Full 360° rotation
          child: SvgPicture.asset(
            width: 160,
            height: 160,
            AssetsManager.STATIC_CYCLONE,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }
}

class CycloneScreen extends ConsumerWidget {
  const CycloneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(globalSearchControllerProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final uiState = ref.watch(cycloneReportTestingProvider).when(
          data: (report) {
            if (report.level > 0) {
              return CycloneWarningUi(cycloneReport: report);
            } else {
              return CycloneNoWarningUi(cycloneReport: report);
            }
          },
          loading: () => LoadingScreen(),
          error: (error, stack) => ErrorScreen(
            title: error.toString(),
          ),
        );

    return Scaffold(
      key: scaffoldKey,
      appBar: MesAppSearchBar(
        searchController: searchController,
        openDrawer: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: MesDrawer(),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        onRefresh: () async => ref.refresh(cycloneReportTestingProvider.future),
        child: uiState,
      ),

      // TODO(Fix the floating action button for cyclone reports)
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     // New FAB
      //     Padding(
      //       padding:
      //           const EdgeInsets.only(bottom: 8.0), // Adds space between FABs
      //       child: FloatingActionButton.small(
      //         backgroundColor: Theme.of(context).colorScheme.secondary,
      //         foregroundColor: Theme.of(context).colorScheme.onSecondary,
      //         onPressed: () {},
      //         child: Icon(Icons.rule_outlined),
      //       ),
      //     ),
      //     // Your existing FAB
      //     FloatingActionButton.extended(
      //       label: Text("Cyclone Names"),
      //       icon: Icon(Icons.cyclone_outlined),
      //       backgroundColor: Theme.of(context).colorScheme.primary,
      //       foregroundColor: Theme.of(context).colorScheme.onPrimary,
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class CycloneNoWarningUi extends StatelessWidget {
  final CycloneReport cycloneReport;

  const CycloneNoWarningUi({
    super.key,
    required this.cycloneReport,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Column(
              children: [Text("No cyclone warning")],
            ),
          ),
        )
      ],
    );
  }
}

class CycloneWarningUi extends StatelessWidget {
  final CycloneReport cycloneReport;

  const CycloneWarningUi({
    super.key,
    required this.cycloneReport,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Mauritius is currently is",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
                Text(
                  "Class ${cycloneReport.level}",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4.0,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                    horizontal: 16.0,
                  ),
                  child: RotatingSvg(
                    level: cycloneReport.level,
                  ),
                ),
                SectionTitle(title: "Next Bulletin"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12.0,
                  children: [
                    TimerCard(
                      time: cycloneReport.getHour,
                      subtitle: "hr",
                    ),
                    Text(
                      ":",
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(color: theme.colorScheme.secondary),
                    ),
                    TimerCard(
                      time: cycloneReport.getMinute,
                      subtitle: "min",
                    )
                  ],
                ),
                SizedBox(height: 32.0),
                SectionTitle(title: "Latest News"),
                SizedBox(
                  height: 200,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    children: cycloneReport.news
                        .map(
                          (item) => NewsItem(
                            news: item,
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final String news;

  const NewsItem({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: MesElevation.card,
      child: Container(
        width: 260.0,
        padding: const EdgeInsets.all(8.0),
        child: Text(news),
      ),
    );
  }
}

class TimerCard extends StatelessWidget {
  final String time;
  final String subtitle;

  const TimerCard({
    super.key,
    required this.time,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: MesElevation.card,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
