import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/models/app/network_info.dart';
import 'package:mauritius_emergency_services/providers/mes_outage_provider.dart';
import 'package:mauritius_emergency_services/providers/settings_providers.dart';
import 'package:mauritius_emergency_services/ui/pages/outages/outages_state.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/pages/outages/outages_provider.g.dart';

@riverpod
class OutagesNotifier extends _$OutagesNotifier {
  @override
  Future<OutagesState> build() async {
    return _fetch();
  }

  Future<OutagesState> _fetch() async {
    try {
      final isConnected = await NetworkInfo().isConnectedToInternet;

      if (!isConnected) {
        return OutagesNoInternet(
          message: t.messages.error.no_internet_connection.capitalize(),
        );
      }

      final lang = ref.watch(mesSettingsProvider.select((s) => s.locale.lang));

      final districtOutages = await ref
          .watch(cebOutageRepositoryProvider)
          .getOutages(lang);

      final hasAnyOutage = districtOutages.any((d) => d.outages.isNotEmpty);

      return hasAnyOutage
          ? OutagesLoaded(districtOutages: districtOutages)
          : const OutagesEmpty();
    } catch (e) {
      return OutagesError(message: "Error loading");
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetch);
  }
}
