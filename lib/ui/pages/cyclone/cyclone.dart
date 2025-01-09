import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/cyclone_report.dart';
import 'package:mauritius_emergency_services/core/providers/search_controller.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/ui/components/appbar.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';
import 'package:mauritius_emergency_services/ui/components/rotating_svg.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';
import 'package:mauritius_emergency_services/ui/components/widgets.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/cyclone_guidelines_sheet.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/cyclone_names_sheet.dart';
import 'package:mauritius_emergency_services/ui/utils/getters.dart';

class CycloneScreen extends ConsumerWidget {
  const CycloneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(globalSearchControllerProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    // Store the cyclone report in a variable to access it later
    final cycloneReportAsync = ref.watch(cycloneReportTestingProvider);

    final uiState = cycloneReportAsync.when(
      data: (report) {
        if (report.level > 0) {
          return _CycloneWarningUi(cycloneReport: report);
        } else {
          return _CycloneNoWarningUi(cycloneReport: report);
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 16.0,
        children: [
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.onSecondary,
            child: Icon(Icons.list_alt_outlined),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                showDragHandle: true,
                enableDrag: true,
                useSafeArea: true,
                builder: (BuildContext context) => CycloneNamesSheet(),
              );
            },
          ),
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            child: Icon(Icons.cyclone_outlined),
            onPressed: () {
              cycloneReportAsync.whenData((report) {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  showDragHandle: true,
                  enableDrag: true,
                  useSafeArea: true,
                  builder: (BuildContext context) => CycloneGuidelinesSheet(
                    cycloneLevel: report.level,
                  ),
                );
              });
            },
          )
        ],
      ),
    );
  }
}

class _CycloneNoWarningUi extends StatelessWidget {
  final CycloneReport cycloneReport;

  const _CycloneNoWarningUi({
    required this.cycloneReport,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                spacing: 32.0,
                children: [
                  Icon(
                    Icons.cloud_outlined,
                    size: 96,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Icon(
                    Icons.cloud_outlined,
                    size: 96,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "There's currently no cyclone warning",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Icon(
                Icons.cloud_outlined,
                size: 96,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _CycloneWarningUi extends StatelessWidget {
  final CycloneReport cycloneReport;

  const _CycloneWarningUi({
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
                    duration: getRotationSpeedFromCycloneLevel(
                      level: cycloneReport.level,
                    ),
                  ),
                ),
                _SectionTitle(title: "Next Bulletin"),
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
                _SectionTitle(title: "Latest News"),
                SizedBox(
                  height: 200,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    children: cycloneReport.news
                        .map(
                          (item) => CycloneNewsItem(
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

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
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
