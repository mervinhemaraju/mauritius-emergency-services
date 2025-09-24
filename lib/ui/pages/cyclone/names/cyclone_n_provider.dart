import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/models/network_info.dart';
import 'package:mauritius_emergency_services/providers/api_providers.dart';
import 'package:mauritius_emergency_services/ui/pages/cyclone/names/cyclone_n_state.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "../../../../generated/pages/cyclone/names/cyclone_n_provider.g.dart";

@riverpod
Future<CycloneNamesState> cycloneNames(Ref ref) async {
  /*
  * Gets the cyclone names
  */

  try {
    // Get the cyclone repository provider
    final repository = ref.watch(mesCycloneRepositoryProvider);

    // Get the network info
    final isConnectedToInternet = await NetworkInfo().isConnectedToInternet;

    // Check if not connected to internet
    if (!isConnectedToInternet) {
      return CycloneNamesNoInternetState(
        t.messages.error.no_internet_connection.capitalize(),
      );
    }

    // Get the cyclone names
    final names = await repository.getCycloneNames();

    // Return the view
    return CycloneNamesUiState(names);
  } catch (e) {
    return CycloneNamesErrorState(
      t.messages.error.cannot_load_cyclone_names,
    );
  }
}
