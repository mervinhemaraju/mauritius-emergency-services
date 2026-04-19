import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/app/network_info.dart';
import 'package:mauritius_emergency_services/data/local/preferences/settings_provider.dart';
import 'package:mauritius_emergency_services/data/remote/api/alerts/mes_alert_provider.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/pages/alerts/alerts_state.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/pages/alerts/alerts_provider.g.dart';

@riverpod
class AlertsNotifier extends _$AlertsNotifier {
  @override
  Future<AlertsState> build() async {
    return _fetch();
  }

  Future<AlertsState> _fetch() async {
    try {
      final isConnected = await MesNetworkInfo().isConnectedToInternet;

      if (!isConnected) {
        return AlertsStateNoInternet(
          message: t.messages.error.no_internet_connection.capitalize(),
        );
      }

      final lang = ref.watch(mesSettingsProvider.select((s) => s.locale.lang));
      final alert = await ref.watch(mesAlertRepositoryProvider).getAlert(lang);

      return alert != null
          ? AlertsStateActive(message: alert)
          : const AlertsStateClear();
    } catch (e) {
      return AlertsStateError(
        message: t.messages.error.cannot_load_data.capitalize(),
      );
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetch);
  }
}
