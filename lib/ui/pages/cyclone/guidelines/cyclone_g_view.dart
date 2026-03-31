import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/cyclone/cyclone_guidelines.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class CycloneGuidelinesSheet extends ConsumerWidget {
  final CycloneGuidelines cycloneGuidelines;

  const CycloneGuidelinesSheet({super.key, required this.cycloneGuidelines});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      expand: false,
      builder: (context, scrollController) => _CycloneGuidelinesUi(
        cycloneGuidelines: cycloneGuidelines,
        scrollController: scrollController,
      ),
    );
  }
}

class _CycloneGuidelinesUi extends StatelessWidget {
  final CycloneGuidelines cycloneGuidelines;
  final ScrollController scrollController;

  const _CycloneGuidelinesUi({
    required this.cycloneGuidelines,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
      children: [
        // ── Header ──
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cs.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.cyclone_outlined, size: 20, color: cs.error),
            ),
            const SizedBox(width: 14),
            Text(
              t.pages.cyclone.guidelines
                  .title(level: cycloneGuidelines.level)
                  .capitalizeAll(),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // ── Description ──
        Container(
          padding: const EdgeInsets.only(left: 14),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: cs.outlineVariant, width: 2),
            ),
          ),
          child: Text(
            cycloneGuidelines.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurface.withValues(alpha: 0.6),
              height: 1.6,
            ),
          ),
        ),

        const SizedBox(height: 28),

        // ── Precautions label ──
        Text(
          t.pages.cyclone.guidelines.header_precautions_title.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            letterSpacing: 0.8,
            color: cs.onSurface.withValues(alpha: 0.5),
          ),
        ),

        const SizedBox(height: 12),

        // ── Precaution items ──
        ...cycloneGuidelines.precautions.indexed.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: cs.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: cs.outlineVariant.withValues(alpha: 0.5),
                  width: 0.5,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${(entry.$1 + 1).toString().padLeft(2, '0')}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface.withValues(alpha: 0.35),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      entry.$2,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.55),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
