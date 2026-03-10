import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_search/search_view.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/pages/ceb/test.dart';

// class CebScreen extends StatelessWidget {
//   const CebScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Get the global key
//     final scaffoldKey = GlobalKey<ScaffoldState>();

//     return Scaffold(
//       key: scaffoldKey,
//       appBar: MesAppSearchBar(
//         openDrawer: () {
//           scaffoldKey.currentState?.openDrawer();
//         },
//       ),
//       drawer: const MesDrawer(),
//       body: const Center(child: Text("Hello from CEB")),
//     );
//   }
// }

class CebScreen extends StatelessWidget {
  const CebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final districtOutages =
        (outages['district_outages'] as List?)?.cast<Map<String, dynamic>>() ??
        [];

    return Scaffold(
      key: scaffoldKey,
      appBar: MesAppSearchBar(
        openDrawer: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: const MesDrawer(),
      body: _CebBody(districtOutages: districtOutages),
    );
  }
}

class _CebBody extends StatelessWidget {
  final List<Map<String, dynamic>> districtOutages;

  const _CebBody({required this.districtOutages});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final active = districtOutages
        .where((d) => (d['outages'] as List).isNotEmpty)
        .toList();
    final inactive = districtOutages
        .where((d) => (d['outages'] as List).isEmpty)
        .toList();

    if (active.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bolt_rounded,
              size: 64,
              color: cs.primary.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No Planned Outages',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'All districts have normal power supply.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        _SummaryCard(activeDistricts: active),
        const SizedBox(height: 24),
        ...active.map((d) => _DistrictSection(district: d)),
        if (inactive.isNotEmpty) ...[
          const SizedBox(height: 16),
          _NoOutagesSection(districts: inactive),
        ],
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final List<Map<String, dynamic>> activeDistricts;

  const _SummaryCard({required this.activeDistricts});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final total = activeDistricts.fold<int>(
      0,
      (sum, d) => sum + (d['outages'] as List).length,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.errorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.error.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.warning_amber_rounded, color: cs.error, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$total Planned Outage${total != 1 ? 's' : ''}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.onErrorContainer,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${activeDistricts.length} district${activeDistricts.length != 1 ? 's' : ''} affected',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onErrorContainer.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DistrictSection extends StatelessWidget {
  final Map<String, dynamic> district;

  const _DistrictSection({required this.district});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final outagesList = district['outages'] as List;
    final name = _fmtDistrict(district['district'] as String);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 10),
            child: Text(
              name,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: cs.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
          ...outagesList.map(
            (o) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _OutageCard(outage: o as Map<String, dynamic>),
            ),
          ),
        ],
      ),
    );
  }

  String _fmtDistrict(String raw) =>
      raw.split('-').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ');
}

class _OutageCard extends StatelessWidget {
  final Map<String, dynamic> outage;

  const _OutageCard({required this.outage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final locality = _titleCase(outage['locality'] as String);
    final streets = (outage['streets'] as List).cast<String>();
    final startDt = DateTime.parse(outage['start_datetime'] as String);
    final endDt = DateTime.parse(outage['end_datetime'] as String);
    final now = DateTime.now();
    final isOngoing = now.isAfter(startDt) && now.isBefore(endDt);
    final isToday =
        startDt.year == now.year &&
        startDt.month == now.month &&
        startDt.day == now.day;

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: isOngoing
            ? Border.all(color: cs.error.withValues(alpha: 0.4))
            : null,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  locality,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (isOngoing)
                _Badge(label: 'ONGOING', color: cs.error, textColor: cs.onError)
              else if (isToday)
                _Badge(
                  label: 'TODAY',
                  color: cs.tertiary,
                  textColor: cs.onTertiary,
                ),
            ],
          ),
          const SizedBox(height: 10),
          _IconLabel(
            icon: Icons.schedule_rounded,
            text: _dateRange(startDt, endDt),
            bold: true,
          ),
          const SizedBox(height: 6),
          _IconLabel(
            icon: Icons.timer_outlined,
            text: _duration(startDt, endDt),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: streets
                .where((s) => s.trim().isNotEmpty)
                .map(
                  (s) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _capFirst(s.trim()),
                      style: theme.textTheme.labelSmall?.copyWith(
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

  String _dateRange(DateTime s, DateTime e) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    String t(DateTime dt) =>
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    return '${days[s.weekday - 1]} ${s.day} ${months[s.month - 1]} · ${t(s)} – ${t(e)}';
  }

  String _duration(DateTime s, DateTime e) {
    final d = e.difference(s);
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return m == 0 ? '${h}h duration' : '${h}h ${m}m duration';
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const _Badge({
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool bold;

  const _IconLabel({required this.icon, required this.text, this.bold = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, size: 15, color: cs.onSurface.withValues(alpha: 0.5)),
        const SizedBox(width: 6),
        Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            color: cs.onSurface.withValues(alpha: 0.6),
            fontWeight: bold ? FontWeight.w500 : null,
          ),
        ),
      ],
    );
  }
}

class _NoOutagesSection extends StatelessWidget {
  final List<Map<String, dynamic>> districts;

  const _NoOutagesSection({required this.districts});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            'NO OUTAGES',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: cs.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: districts.map((d) {
            final name = (d['district'] as String)
                .split('-')
                .map((w) => w[0].toUpperCase() + w.substring(1))
                .join(' ');
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: cs.surfaceContainerLow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 14,
                    color: cs.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    name,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
