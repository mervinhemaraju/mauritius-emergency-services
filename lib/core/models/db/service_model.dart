import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:objectbox/objectbox.dart';

final Logger log = Logger('service_model.dart');

@Entity()
class ServiceModel {
  @Id()
  int id = 0;

  @Unique()
  final String identifier;
  final String name;
  final String type;
  final String language;
  final List<String> emails;
  final int mainContact;

  @Property(type: PropertyType.byteVector)
  Uint8List iconData;

  @Property(type: PropertyType.intVector)
  final List<int> otherContacts;

  ServiceModel({
    this.id = 0,
    required this.identifier,
    required this.name,
    required this.type,
    required this.emails,
    required this.mainContact,
    required this.otherContacts,
    required this.language,
    required this.iconData,
  });

  // Convert Service to ServiceModel with image download
  static Future<ServiceModel> fromService(
    Service service,
    String language,
  ) async {
    Uint8List downloadedIconData = Uint8List(0);

    try {
      final response = await http.get(Uri.parse(service.icon));
      if (response.statusCode == 200) {
        downloadedIconData = response.bodyBytes;
      }
    } catch (e) {
      log.severe('Failed to download icon for ${service.identifier}: $e');
    }

    return ServiceModel(
      identifier: service.identifier,
      name: service.name,
      type: service.type,
      emails: service.emails,
      mainContact: service.mainContact,
      otherContacts: service.otherContacts,
      language: language,
      iconData: downloadedIconData,
    );
  }

  // Convert ServiceModel to Service
  Service toService() {
    return Service(
      identifier: identifier,
      name: name,
      type: type,
      icon: "", // Add empty string
      emails: emails,
      mainContact: mainContact,
      otherContacts: otherContacts,
      iconData: iconData,
    );
  }
}
