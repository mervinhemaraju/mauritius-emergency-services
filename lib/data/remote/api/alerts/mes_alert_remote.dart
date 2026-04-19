import 'package:dio/dio.dart';
import 'package:mauritius_emergency_services/data/contracts/alerts/mes_alert_source.dart';
import 'package:mauritius_emergency_services/data/helpers/api_constants.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class MesAlertRemote implements MesAlertSource {
  final Dio dio;

  const MesAlertRemote(this.dio);

  @override
  Future<String?> getAlert(String lang) async {
    final response = await dio.get(
      ApiConstants.versioned(lang, 'alerts'),
    );

    if (response.data['success'] != true) {
      final msg = response.data['message']?.toString();
      throw Exception(
        (msg != null && msg.isNotEmpty)
            ? msg
            : t.messages.error.cannot_load_alert.capitalize(),
      );
    }

    final alert = response.data['alert'];

    return (alert is String && alert.isNotEmpty) ? alert : null;
  }
}
