import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/models/cyclone_report.dart';
import 'package:mauritius_emergency_services/providers/cyclone_providers.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_search.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';
import 'package:mauritius_emergency_services/ui/components/rotating_svg.dart';
import 'package:mauritius_emergency_services/ui/components/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/view_loading.dart';
import 'package:mauritius_emergency_services/ui/components/widgets.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/cyclone_guidelines_sheet.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/cyclone_names_sheet.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:mauritius_emergency_services/ui/utils/getters.dart';

class CycloneScreen extends ConsumerWidget {
  const CycloneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the global key
    final scaffoldKey = GlobalKey<ScaffoldState>();

    // Store the cyclone report in a variable to access it later
    //TODO(Change back before going to prod)
    final cycloneReportAsync = ref.watch(cycloneReportTestingProvider);

    // Get the cyclone view state
    final uiState = cycloneReportAsync.when(
      data: (report) {
        if (report.level > 0) {
          return _CycloneWarningUi(cycloneReport: report);
        } else {
          return _CycloneNoWarningUi(cycloneReport: report);
        }
      },
      loading: () => const LoadingScreen(),
      error: (error, stack) => ErrorScreen(
        title: t.messages.error.cannot_load_cyclone_report.capitalize(),
        showErrorImage: true,
        retryAction: () => ref.refresh(cycloneReportProvider.future),
      ),
    );

    // Return the view
    return Scaffold(
      key: scaffoldKey,
      appBar: MesAppSearchBar(
        openDrawer: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: const MesDrawer(),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        //TODO(Change back before going to prod)
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
            child: const Icon(Icons.list_alt_outlined),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                showDragHandle: true,
                enableDrag: true,
                useSafeArea: true,
                builder: (BuildContext context) => const CycloneNamesSheet(),
              );
            },
          ),
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            child: const Icon(Icons.cyclone_outlined),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsManager.STATIC_WEATHER,
                  width: 220,
                  height: 220,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    t.pages.cyclone.no_warning.capitalize(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
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
                  t.pages.cyclone.warning.title.capitalize(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
                Text(
                  t.pages.cyclone.warning
                      .subtitle(level: cycloneReport.level.toString())
                      .capitalize(),
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
                _SectionTitle(
                  title: t.pages.cyclone.warning.next_bulletin_title
                      .capitalizeAll(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12.0,
                  children: [
                    TimerCard(
                      time: cycloneReport.getHour,
                      subtitle: t.others.hour_abbr,
                    ),
                    Text(
                      ":",
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(color: theme.colorScheme.secondary),
                    ),
                    TimerCard(
                      time: cycloneReport.getMinute,
                      subtitle: t.others.minute_abbr,
                    )
                  ],
                ),
                const SizedBox(height: 32.0),
                _SectionTitle(
                    title: t.pages.cyclone.warning.latest_news_title
                        .capitalizeAll()),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: cycloneReport.news.length,
                    prototypeItem: const CycloneNewsItem(
                      news: "",
                    ),
                    itemBuilder: (context, index) {
                      return CycloneNewsItem(
                        news: cycloneReport.news[index],
                      );
                    },
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
