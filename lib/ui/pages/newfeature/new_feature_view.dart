import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/data/local/preferences/settings_provider.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';

// TODO(Add this to page to translations)
class NewFeatureAnnouncementScreen extends ConsumerWidget {
  const NewFeatureAnnouncementScreen({super.key});

  Future<void> _onExplore(WidgetRef ref, BuildContext context) async {
    await ref.read(mesSettingsProvider.notifier).markAsAwareOfNewFeature();
    if (context.mounted) context.go(OutagesRoute.path);
  }

  Future<void> _onDismiss(WidgetRef ref, BuildContext context) async {
    await ref.read(mesSettingsProvider.notifier).markAsAwareOfNewFeature();
    if (context.mounted) context.go(HomeRoute.path);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return PopScope(
      // Intercept back swipe / back button and go home instead
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _onDismiss(ref, context);
      },
      child: Scaffold(
        backgroundColor: cs.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),

                // ── "What's new" pill ────────────────────────────────────
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 6,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: cs.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          "What's new",
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: cs.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Headline ─────────────────────────────────────────────
                Text(
                  'Power outage\nschedules,',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                    color: cs.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  'at a glance.',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                    color: cs.primary,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Stay ahead of CEB planned interruptions across all districts — fully offline-ready.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: cs.onSurface.withValues(alpha: 0.55),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 36),

                // ── Illustration card ────────────────────────────────────
                _IllustrationCard(cs: cs, theme: theme),

                const SizedBox(height: 36),

                // ── Feature highlights ───────────────────────────────────
                _FeatureRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Date-grouped timeline',
                  description:
                      "Outages sorted by day so you're never caught off guard",
                  cs: cs,
                  theme: theme,
                ),
                const SizedBox(height: 14),
                _FeatureRow(
                  icon: Icons.place_outlined,
                  label: 'Filter by district',
                  description: 'Jump straight to what affects your area',
                  cs: cs,
                  theme: theme,
                ),
                const SizedBox(height: 14),
                _FeatureRow(
                  icon: Icons.bolt_rounded,
                  label: 'Live status indicator',
                  description: 'Ongoing interruptions highlighted in real time',
                  cs: cs,
                  theme: theme,
                ),

                const SizedBox(height: 48),

                // ── CTAs ─────────────────────────────────────────────────
                FilledButton(
                  onPressed: () => _onExplore(ref, context),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      const Icon(Icons.bolt_rounded, size: 18),
                      Text(
                        'View outage schedule',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () => _onDismiss(ref, context),
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Maybe later',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.45),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Illustration card ────────────────────────────────────────────────────────

class _IllustrationCard extends StatelessWidget {
  final ColorScheme cs;
  final ThemeData theme;

  const _IllustrationCard({required this.cs, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: cs.primaryContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.primary.withValues(alpha: 0.12), width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // ── Big bolt icon ──
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(Icons.bolt_rounded, size: 38, color: cs.primary),
          ),

          const SizedBox(width: 20),

          // ── Mini timeline preview ──
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                _MiniOutageRow(
                  locality: 'Vacoas',
                  time: '08:30 – 17:00',
                  isOngoing: true,
                  cs: cs,
                  theme: theme,
                ),
                _MiniOutageRow(
                  locality: 'Quatre-Bornes',
                  time: '09:00 – 12:00',
                  isOngoing: false,
                  cs: cs,
                  theme: theme,
                ),
                _MiniOutageRow(
                  locality: 'Central Flacq',
                  time: '08:30 – 15:00',
                  isOngoing: false,
                  cs: cs,
                  theme: theme,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniOutageRow extends StatelessWidget {
  final String locality;
  final String time;
  final bool isOngoing;
  final ColorScheme cs;
  final ThemeData theme;

  const _MiniOutageRow({
    required this.locality,
    required this.time,
    required this.isOngoing,
    required this.cs,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: isOngoing ? cs.error : cs.onSurface.withValues(alpha: 0.25),
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            locality,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: cs.onSurface.withValues(alpha: 0.85),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          time,
          style: theme.textTheme.labelSmall?.copyWith(
            fontSize: 10,
            color: cs.onSurface.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }
}

// ─── Feature highlight row ────────────────────────────────────────────────────

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final ColorScheme cs;
  final ThemeData theme;

  const _FeatureRow({
    required this.icon,
    required this.label,
    required this.description,
    required this.cs,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 14,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: cs.secondaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: cs.onSecondaryContainer),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
              ),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onSurface.withValues(alpha: 0.5),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
