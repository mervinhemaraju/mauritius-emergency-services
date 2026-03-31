import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/models/outage/flat_outage.dart';
import 'package:mauritius_emergency_services/models/outage/mes_district_outage.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_search/search_view.dart';
import 'package:mauritius_emergency_services/ui/widgets/chips/chip_selectable.dart';
import 'package:mauritius_emergency_services/ui/widgets/chips/chip_status.dart';
import 'package:mauritius_emergency_services/ui/widgets/drawers/drawer_primary.dart';
import 'package:mauritius_emergency_services/ui/components/views/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/views/view_loading.dart';
import 'package:mauritius_emergency_services/ui/pages/outages/outages_provider.dart';
import 'package:mauritius_emergency_services/ui/pages/outages/outages_state.dart';

class OutagesScreen extends ConsumerWidget {
  const OutagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final uiState = ref
        .watch(outagesProvider)
        .when(
          data: (state) => state,
          loading: () => const OutagesLoading(),
          error: (error, _) => OutagesError(message: error.toString()),
        );

    void retryAction() => ref.read(outagesProvider.notifier).refresh();

    final uiView = switch (uiState) {
      OutagesLoading() => const LoadingScreen(),
      OutagesError() => ErrorScreen(
        title: uiState.message,
        showErrorImage: true,
        retryAction: retryAction,
      ),
      OutagesNoInternet() => ErrorScreen(
        title: uiState.message,
        showInternetErrorImage: true,
        retryAction: retryAction,
      ),
      OutagesEmpty() => const _EmptyState(),
      OutagesLoaded() => _OutagesBody(districtOutages: uiState.districtOutages),
    };

    return Scaffold(
      key: scaffoldKey,
      appBar: MesAppSearchBar(
        openDrawer: () => scaffoldKey.currentState?.openDrawer(),
      ),
      drawer: const MesDrawerPrimary(),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        onRefresh: () async => ref.read(outagesProvider.notifier).refresh(),
        child: uiView,
      ),
    );
  }
}

// ─── Main Body ────────────────────────────────────────────────────────────────

class _OutagesBody extends StatefulWidget {
  final List<CebDistrictOutage> districtOutages;

  const _OutagesBody({required this.districtOutages});

  @override
  State<_OutagesBody> createState() => _OutagesBodyState();
}

class _OutagesBodyState extends State<_OutagesBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedDistrict;

  // ── Derived data ──────────────────────────────────────────────────────────

  List<MesFlatOutage> get _allOutages {
    final list = <MesFlatOutage>[];
    for (final d in widget.districtOutages) {
      for (final o in d.outages) {
        list.add(MesFlatOutage(district: d.district, outage: o));
      }
    }
    list.sort(
      (a, b) => a.outage.startDatetime.compareTo(b.outage.startDatetime),
    );
    return list;
  }

  List<String> get _sortedDateKeys =>
      _allOutages.map((o) => o.dateKey).toSet().toList()..sort();

  List<String> get _districts =>
      _allOutages.map((o) => o.district).toSet().toList()..sort();

  List<MesFlatOutage> _outagesForDate(String dateKey) => _allOutages.where((o) {
    final matchDate = o.dateKey == dateKey;
    final matchDistrict =
        _selectedDistrict == null || o.district == _selectedDistrict;
    return matchDate && matchDistrict;
  }).toList();

  int get _ongoingCount => _allOutages.where((o) => o.isOngoing).length;

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    final dateKeys = _sortedDateKeys;
    final now = DateTime.now();
    final todayKey =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final todayIndex = dateKeys.indexOf(todayKey);

    _tabController = TabController(
      length: dateKeys.isEmpty ? 1 : dateKeys.length,
      vsync: this,
      initialIndex: todayIndex >= 0 ? todayIndex : 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final dateKeys = _sortedDateKeys;
    final allOutages = _allOutages;
    final districts = _districts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Hero header ─────────────────────────────────────────────────
        _HeroHeader(
          total: allOutages.length,
          ongoingCount: _ongoingCount,
          districtCount: districts.length,
          theme: theme,
          cs: cs,
        ),

        // ── District filter chips ────────────────────────────────────────
        if (districts.length > 1)
          _DistrictFilter(
            districts: districts,
            selected: _selectedDistrict,
            onChanged: (d) => setState(
              () => _selectedDistrict = _selectedDistrict == d ? null : d,
            ),
            theme: theme,
            cs: cs,
          ),

        // ── Date tab bar ─────────────────────────────────────────────────
        if (dateKeys.isNotEmpty)
          _DateTabBar(
            dateKeys: dateKeys,
            controller: _tabController,
            allOutages: allOutages,
            theme: theme,
            cs: cs,
          ),

        // ── Tab content ──────────────────────────────────────────────────
        Expanded(
          child: dateKeys.isEmpty
              ? const _EmptyState()
              : TabBarView(
                  controller: _tabController,
                  children: dateKeys.map((dk) {
                    final outages = _outagesForDate(dk);
                    if (outages.isEmpty) {
                      return _NoDistrictResults(cs: cs, theme: theme);
                    }
                    return _OutageList(outages: outages);
                  }).toList(),
                ),
        ),
      ],
    );
  }
}

// ─── Hero Header ─────────────────────────────────────────────────────────────

class _HeroHeader extends StatelessWidget {
  final int total;
  final int ongoingCount;
  final int districtCount;
  final ThemeData theme;
  final ColorScheme cs;

  const _HeroHeader({
    required this.total,
    required this.ongoingCount,
    required this.districtCount,
    required this.theme,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    final outageLabel = total == 1
        ? t.pages.power_outages.hero.outage_singular
        : t.pages.power_outages.hero.outage_plural;

    final districtLabel = districtCount == 1
        ? t.pages.power_outages.hero.across_districts_singular(
            count: districtCount,
          )
        : t.pages.power_outages.hero.across_districts_plural(
            count: districtCount,
          );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
      decoration: BoxDecoration(
        color: cs.errorContainer.withValues(alpha: 0.45),
        border: Border(
          bottom: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.25)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$total',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: cs.error,
                      height: 1,
                      letterSpacing: -2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 5),
                    child: Text(
                      outageLabel,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: cs.onErrorContainer.withValues(alpha: 0.65),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                districtLabel,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onErrorContainer.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (ongoingCount > 0) ...[
                MesChipStatus(
                  label: t.pages.power_outages.hero.live_now(
                    count: ongoingCount,
                  ),
                  backgroundColor: cs.error,
                  foregroundColor: cs.onError,
                  icon: Icons.fiber_manual_record,
                ),
                const SizedBox(height: 6),
              ],
              MesChipStatus(
                label: t.pages.power_outages.hero.ceb_outages,
                backgroundColor: cs.surfaceContainerHighest,
                foregroundColor: cs.onSurface.withValues(alpha: 0.55),
                icon: Icons.bolt_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── District Filter ──────────────────────────────────────────────────────────

class _DistrictFilter extends StatelessWidget {
  final List<String> districts;
  final String? selected;
  final void Function(String) onChanged;
  final ThemeData theme;
  final ColorScheme cs;

  const _DistrictFilter({
    required this.districts,
    required this.selected,
    required this.onChanged,
    required this.theme,
    required this.cs,
  });

  String _fmt(String raw) => raw
      .split('-')
      .map((w) => w.isNotEmpty ? w[0].toUpperCase() + w.substring(1) : '')
      .join(' ');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          MesChipSelectable(
            label: t.pages.power_outages.filter.all,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            selected: selected == null,
            onTap: () {
              if (selected != null) onChanged(selected!);
            },
          ),
          ...districts.map(
            (d) => Padding(
              padding: const EdgeInsets.only(left: 6),
              child: MesChipSelectable(
                label: _fmt(d),
                selected: selected == d,
                onTap: () => onChanged(d),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Date Tab Bar ─────────────────────────────────────────────────────────────

class _DateTabBar extends StatelessWidget {
  final List<String> dateKeys;
  final TabController controller;
  final List<MesFlatOutage> allOutages;
  final ThemeData theme;
  final ColorScheme cs;

  const _DateTabBar({
    required this.dateKeys,
    required this.controller,
    required this.allOutages,
    required this.theme,
    required this.cs,
  });

  // Weekday index 1=Mon … 7=Sun, matching DateTime.weekday
  static List<String> _localizedDays() => [
    t.others.days['mon']!,
    t.others.days['tue']!,
    t.others.days['wed']!,
    t.others.days['thu']!,
    t.others.days['fri']!,
    t.others.days['sat']!,
    t.others.days['sun']!,
  ];

  // Month index 0=Jan … 11=Dec, matching DateTime.month - 1
  static List<String> _localizedMonths() => [
    t.others.months['jan']!,
    t.others.months['feb']!,
    t.others.months['mar']!,
    t.others.months['apr']!,
    t.others.months['may']!,
    t.others.months['jun']!,
    t.others.months['jul']!,
    t.others.months['aug']!,
    t.others.months['sep']!,
    t.others.months['oct']!,
    t.others.months['nov']!,
    t.others.months['dec']!,
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = _localizedDays();
    final months = _localizedMonths();

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.3)),
        ),
      ),
      child: TabBar(
        controller: controller,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: cs.primary,
        indicatorWeight: 3,
        dividerColor: Colors.transparent,
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        tabs: dateKeys.map((dk) {
          final dt = DateTime.parse(dk);
          final isToday =
              dt.year == now.year && dt.month == now.month && dt.day == now.day;
          final isTomorrow =
              dt.difference(DateTime(now.year, now.month, now.day)).inDays == 1;
          final count = allOutages.where((o) => o.dateKey == dk).length;
          final hasOngoing = allOutages.any(
            (o) => o.dateKey == dk && o.isOngoing,
          );

          final String dayLabel;
          if (isToday) {
            dayLabel = t.others.today;
          } else if (isTomorrow) {
            dayLabel = t.others.tomorrow;
          } else {
            dayLabel = days[dt.weekday - 1];
          }

          return _DateTab(
            dayLabel: dayLabel,
            dateLabel: '${dt.day} ${months[dt.month - 1]}',
            count: count,
            isToday: isToday,
            hasOngoing: hasOngoing,
            cs: cs,
            theme: theme,
          );
        }).toList(),
      ),
    );
  }
}

class _DateTab extends StatelessWidget {
  final String dayLabel;
  final String dateLabel;
  final int count;
  final bool isToday;
  final bool hasOngoing;
  final ColorScheme cs;
  final ThemeData theme;

  const _DateTab({
    required this.dayLabel,
    required this.dateLabel,
    required this.count,
    required this.isToday,
    required this.hasOngoing,
    required this.cs,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 58,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  dayLabel,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: isToday ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
                if (hasOngoing) ...[
                  const SizedBox(width: 4),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: cs.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 2),
            Text(
              dateLabel,
              style: theme.textTheme.labelSmall?.copyWith(
                color: cs.onSurface.withValues(alpha: 0.4),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
              decoration: BoxDecoration(
                color: isToday
                    ? cs.primary.withValues(alpha: 0.12)
                    : cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$count',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isToday
                      ? cs.primary
                      : cs.onSurface.withValues(alpha: 0.45),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Outage List ──────────────────────────────────────────────────────────────

class _OutageList extends StatelessWidget {
  final List<MesFlatOutage> outages;

  const _OutageList({required this.outages});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 40),
      itemCount: outages.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) => _OutageCard(flat: outages[i]),
    );
  }
}

// ─── Outage Card ──────────────────────────────────────────────────────────────

class _OutageCard extends StatefulWidget {
  final MesFlatOutage flat;

  const _OutageCard({required this.flat});

  @override
  State<_OutageCard> createState() => _OutageCardState();
}

class _OutageCardState extends State<_OutageCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _ctrl.forward() : _ctrl.reverse();
  }

  static String _fmt(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  static String _titleCase(String raw) => raw
      .split(' ')
      .map(
        (w) => w.isNotEmpty
            ? w[0].toUpperCase() + w.substring(1).toLowerCase()
            : '',
      )
      .join(' ');

  static String _fmtDistrict(String raw) => raw
      .split('-')
      .map((w) => w.isNotEmpty ? w[0].toUpperCase() + w.substring(1) : '')
      .join(' ');

  static String _duration(DateTime s, DateTime e) {
    final d = e.difference(s);
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return m == 0 ? '${h}h' : '${h}h ${m}m';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final o = widget.flat.outage;
    final isOngoing = widget.flat.isOngoing;
    final isPast = widget.flat.isPast;
    final streets = o.streets.where((s) => s.trim().isNotEmpty).toList();

    final Color accentColor = isOngoing
        ? cs.error
        : isPast
        ? cs.onSurface.withValues(alpha: 0.18)
        : cs.primary;

    return GestureDetector(
      onTap: _toggle,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: isOngoing
              ? Border.all(color: cs.error.withValues(alpha: 0.4), width: 1.5)
              : null,
        ),
        clipBehavior: Clip.hardEdge,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left accent stripe
              Container(width: 4, color: accentColor),

              // Content
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Time block
                          SizedBox(
                            width: 54,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _fmt(o.startDatetime),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    height: 1,
                                    letterSpacing: -0.5,
                                    color: isOngoing
                                        ? cs.error
                                        : isPast
                                        ? cs.onSurface.withValues(alpha: 0.3)
                                        : cs.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 1.5,
                                      color: cs.outlineVariant.withValues(
                                        alpha: 0.7,
                                      ),
                                      margin: const EdgeInsets.only(right: 4),
                                    ),
                                    Text(
                                      _fmt(o.endDatetime),
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            fontSize: 11,
                                            color: cs.onSurface.withValues(
                                              alpha: isPast ? 0.25 : 0.45,
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: accentColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    _duration(o.startDatetime, o.endDatetime),
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: accentColor.withValues(
                                        alpha: isPast ? 0.35 : 0.85,
                                      ),
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Vertical divider
                          Container(
                            width: 1,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  cs.outlineVariant.withValues(alpha: 0),
                                  cs.outlineVariant.withValues(alpha: 0.5),
                                  cs.outlineVariant.withValues(alpha: 0),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),

                          // Locality info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isOngoing)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 5,
                                          height: 5,
                                          margin: const EdgeInsets.only(
                                            right: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: cs.error,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Text(
                                          t.pages.power_outages.card.ongoing,
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w800,
                                                color: cs.error,
                                                letterSpacing: 1.0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                Text(
                                  _titleCase(o.locality),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.3,
                                    color: isPast
                                        ? cs.onSurface.withValues(alpha: 0.35)
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.place_outlined,
                                      size: 11,
                                      color: cs.onSurface.withValues(
                                        alpha: 0.35,
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      _fmtDistrict(widget.flat.district),
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            fontSize: 11,
                                            color: cs.onSurface.withValues(
                                              alpha: 0.4,
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Chevron + street count
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedRotation(
                                turns: _expanded ? 0.5 : 0,
                                duration: const Duration(milliseconds: 260),
                                curve: Curves.easeInOutCubic,
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 22,
                                  color: cs.onSurface.withValues(alpha: 0.3),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: cs.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  t.pages.power_outages.tabs.street_count(
                                    count: streets.length,
                                  ),
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: cs.onSurface.withValues(alpha: 0.4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Animated streets expansion
                    SizeTransition(
                      sizeFactor: _anim,
                      axisAlignment: -1,
                      child: _StreetPanel(
                        streets: streets,
                        accentColor: accentColor,
                        cs: cs,
                        theme: theme,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Street Panel ─────────────────────────────────────────────────────────────

class _StreetPanel extends StatelessWidget {
  final List<String> streets;
  final Color accentColor;
  final ColorScheme cs;
  final ThemeData theme;

  const _StreetPanel({
    required this.streets,
    required this.accentColor,
    required this.cs,
    required this.theme,
  });

  String _capFirst(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainer.withValues(alpha: 0.55),
        border: Border(
          top: BorderSide(color: accentColor.withValues(alpha: 0.15)),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.pages.power_outages.card.affected_streets,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: accentColor.withValues(alpha: 0.65),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: streets
                .map(
                  (s) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: cs.outlineVariant.withValues(alpha: 0.45),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      _capFirst(s.trim()),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        color: cs.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ─── No district results ──────────────────────────────────────────────────────

class _NoDistrictResults extends StatelessWidget {
  final ColorScheme cs;
  final ThemeData theme;

  const _NoDistrictResults({required this.cs, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.filter_alt_off_outlined,
            size: 32,
            color: cs.onSurface.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 10),
          Text(
            t.pages.power_outages.no_district_results,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Empty state ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.07),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.power_rounded,
                  size: 36,
                  color: cs.primary.withValues(alpha: 0.35),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                t.pages.power_outages.empty.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                t.pages.power_outages.empty.subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurface.withValues(alpha: 0.45),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
