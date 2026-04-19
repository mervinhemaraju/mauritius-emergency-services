import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_search/search_view.dart';
import 'package:mauritius_emergency_services/ui/components/views/view_error.dart';
import 'package:mauritius_emergency_services/ui/components/views/view_loading.dart';
import 'package:mauritius_emergency_services/ui/pages/alerts/alerts_provider.dart';
import 'package:mauritius_emergency_services/ui/pages/alerts/alerts_state.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:mauritius_emergency_services/ui/widgets/drawers/drawer_primary.dart';

class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    void retryAction() => ref.read(alertsProvider.notifier).refresh();

    final uiState = ref
        .watch(alertsProvider)
        .when(
          data: (state) => state,
          loading: () => const AlertsStateLoading(),
          error: (e, _) => AlertsStateError(message: e.toString().capitalize()),
        );

    final uiView = switch (uiState) {
      AlertsStateLoading() => const LoadingScreen(),
      AlertsStateError() => ErrorScreen(
        title: uiState.message,
        showErrorImage: true,
        retryAction: retryAction,
      ),
      AlertsStateNoInternet() => ErrorScreen(
        title: uiState.message,
        showInternetErrorImage: true,
        retryAction: retryAction,
      ),
      AlertsStateClear() => const _AlertsClearUi(),
      AlertsStateActive() => _AlertsActiveUi(message: uiState.message),
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
        onRefresh: () async => ref.read(alertsProvider.notifier).refresh(),
        child: uiView,
      ),
    );
  }
}

// ── No alerts ──────────────────────────────────────────────────────────────

class _AlertsClearUi extends StatelessWidget {
  const _AlertsClearUi();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_off_outlined,
                    size: 60,
                    color: cs.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  t.pages.alerts.title.capitalizeAll(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t.messages.info.no_active_alert.capitalize(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurface.withValues(alpha: 0.5),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Active alert ───────────────────────────────────────────────────────────

class _AlertsActiveUi extends StatelessWidget {
  final String message;

  const _AlertsActiveUi({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Alert badge ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: cs.errorContainer,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 6,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 16,
                            color: cs.error,
                          ),
                          Text(
                            t.messages.info.active_alert.capitalizeAll(),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: cs.error,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ── Alert card ──
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: cs.outlineVariant.withValues(alpha: 0.5),
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top accent line
                      Container(
                        height: 3,
                        width: 40,
                        decoration: BoxDecoration(
                          color: cs.error,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        message,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.65,
                          color: cs.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
