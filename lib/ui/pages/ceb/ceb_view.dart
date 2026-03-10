import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_search/search_view.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/pages/ceb/test.dart';

class CebScreen extends StatelessWidget {
  const CebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: MesAppSearchBar(
        openDrawer: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: const MesDrawer(),
      body: _CebBody(
        districtOutages:
            (outages['district_outages'] as List?)
                ?.cast<Map<String, dynamic>>() ??
            [],
      ),
    );
  }
}

// ─── Models ──────────────────────────────────────────────────────────────────

class _Outage {
  final String district;
  final String locality;
  final DateTime start;
  final DateTime end;
  final List<String> streets;

  const _Outage({
    required this.district,
    required this.locality,
    required this.start,
    required this.end,
    required this.streets,
  });

  bool get isOngoing {
    final now = DateTime.now();
    return now.isAfter(start) && now.isBefore(end);
  }

  bool get isToday {
    final now = DateTime.now();
    return start.year == now.year &&
        start.month == now.month &&
        start.day == now.day;
  }

  String get dateKey =>
      '${start.year}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}';
}

// ─── Body ────────────────────────────────────────────────────────────────────

class _CebBody extends StatefulWidget {
  final List<Map<String, dynamic>> districtOutages;

  const _CebBody({required this.districtOutages});

  @override
  State<_CebBody> createState() => _CebBodyState();
}

class _CebBodyState extends State<_CebBody> {
  String? _selectedDistrict;

  List<_Outage> get _allOutages {
    final list = <_Outage>[];
    for (final d in widget.districtOutages) {
      final district = d['district'] as String;
      for (final o in (d['outages'] as List)) {
        final map = o as Map<String, dynamic>;
        list.add(
          _Outage(
            district: district,
            locality: map['locality'] as String,
            start: DateTime.parse(map['start_datetime'] as String),
            end: DateTime.parse(map['end_datetime'] as String),
            streets: (map['streets'] as List).cast<String>(),
          ),
        );
      }
    }
    list.sort((a, b) => a.start.compareTo(b.start));
    return list;
  }

  List<String> get _affectedDistricts {
    return _allOutages.map((o) => o.district).toSet().toList()..sort();
  }

  List<_Outage> get _filtered {
    if (_selectedDistrict == null) return _allOutages;
    return _allOutages.where((o) => o.district == _selectedDistrict).toList();
  }

  /// Groups outages by date key
  Map<String, List<_Outage>> get _grouped {
    final map = <String, List<_Outage>>{};
    for (final o in _filtered) {
      map.putIfAbsent(o.dateKey, () => []).add(o);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    if (_allOutages.isEmpty) {
      return _EmptyState();
    }

    final grouped = _grouped;
    final dateKeys = grouped.keys.toList()..sort();
    final affected = _affectedDistricts;

    return Column(
      children: [
        // ── Status bar ──
        Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: cs.errorContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: cs.error.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.bolt_rounded, size: 18, color: cs.error),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_allOutages.length} Interruption${_allOutages.length != 1 ? 's' : ''} Scheduled',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onErrorContainer,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'Across ${_affectedDistricts.length} district${_affectedDistricts.length != 1 ? 's' : ''}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onErrorContainer.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ── District filter chips ──
        if (affected.length > 1) const Gap(16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
          child: Row(
            children: [
              _FilterChip(
                label: 'All',
                selected: _selectedDistrict == null,
                onTap: () => setState(() => _selectedDistrict = null),
              ),
              const SizedBox(width: 8),
              ...affected.map(
                (d) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _FilterChip(
                    label: _fmtDistrict(d),
                    selected: _selectedDistrict == d,
                    onTap: () => setState(
                      () =>
                          _selectedDistrict = _selectedDistrict == d ? null : d,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Timeline ──
        Expanded(
          child: _filtered.isEmpty
              ? Center(
                  child: Text(
                    'No outages for this district.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 32),
                  itemCount: dateKeys.length,
                  itemBuilder: (context, i) {
                    final key = dateKeys[i];
                    final items = grouped[key]!;
                    return _DateGroup(dateKey: key, outages: items);
                  },
                ),
        ),
      ],
    );
  }

  String _fmtDistrict(String raw) =>
      raw.split('-').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ');
}

// ─── Empty State ─────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.power_rounded,
            size: 56,
            color: cs.primary.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'All Clear',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'No power interruptions scheduled.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Filter Chip ─────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected
                ? cs.onPrimaryContainer
                : cs.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}

// ─── Date Group ──────────────────────────────────────────────────────────────

class _DateGroup extends StatelessWidget {
  final String dateKey;
  final List<_Outage> outages;

  const _DateGroup({required this.dateKey, required this.outages});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final dt = DateTime.parse(dateKey);
    final now = DateTime.now();
    final isToday =
        dt.year == now.year && dt.month == now.month && dt.day == now.day;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isToday ? cs.primary : cs.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${dt.day}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isToday ? cs.onPrimary : cs.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isToday ? 'Today' : _dayName(dt),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      isToday ? _fullDate(dt) : _monthYear(dt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${outages.length}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Outage tiles under this date
          ...outages.map((o) => _OutageTile(outage: o)),
        ],
      ),
    );
  }

  String _dayName(DateTime dt) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[dt.weekday - 1];
  }

  String _monthYear(DateTime dt) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[dt.month - 1]} ${dt.year}';
  }

  String _fullDate(DateTime dt) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${days[dt.weekday - 1]}, ${dt.day} ${months[dt.month - 1]}';
  }
}

// ─── Outage Tile ─────────────────────────────────────────────────────────────

class _OutageTile extends StatefulWidget {
  final _Outage outage;

  const _OutageTile({required this.outage});

  @override
  State<_OutageTile> createState() => _OutageTileState();
}

class _OutageTileState extends State<_OutageTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final o = widget.outage;

    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          border: o.isOngoing
              ? Border.all(color: cs.error.withValues(alpha: 0.5), width: 1.5)
              : null,
        ),
        child: Column(
          children: [
            // ── Main row ──
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  // Time column
                  SizedBox(
                    width: 52,
                    child: Column(
                      children: [
                        Text(
                          _fmtTime(o.start),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: o.isOngoing ? cs.error : cs.onSurface,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 14,
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          color: cs.outlineVariant,
                        ),
                        Text(
                          _fmtTime(o.end),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: cs.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Locality & district
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _titleCase(o.locality),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${_fmtDistrict(o.district)} · ${_duration(o.start, o.end)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: cs.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Status + expand
                  if (o.isOngoing)
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: cs.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 20,
                    color: cs.onSurface.withValues(alpha: 0.3),
                  ),
                ],
              ),
            ),

            // ── Expanded streets ──
            if (_expanded)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      height: 1,
                      color: cs.outlineVariant.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Affected Areas',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: cs.onSurface.withValues(alpha: 0.4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...o.streets
                        .where((s) => s.trim().isNotEmpty)
                        .map(
                          (s) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: cs.onSurface.withValues(
                                        alpha: 0.3,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _capFirst(s.trim()),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: cs.onSurface.withValues(
                                        alpha: 0.7,
                                      ),
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _fmtTime(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  String _titleCase(String raw) => raw
      .split(' ')
      .map(
        (w) => w.isNotEmpty
            ? w[0].toUpperCase() + w.substring(1).toLowerCase()
            : '',
      )
      .join(' ');

  String _capFirst(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : '';

  String _fmtDistrict(String raw) =>
      raw.split('-').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ');

  String _duration(DateTime s, DateTime e) {
    final d = e.difference(s);
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return m == 0 ? '${h}h' : '${h}h ${m}m';
  }
}
