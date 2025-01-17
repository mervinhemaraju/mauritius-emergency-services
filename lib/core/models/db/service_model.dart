import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:objectbox/objectbox.dart';

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

  // FIXME(IconData not getting stored in the database)
  @Property(type: PropertyType.byteVector)
  Uint8List? iconData;

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
    this.iconData,
  });

  // Convert Service to ServiceModel with image download
  static Future<ServiceModel> fromService(
      Service service, String language) async {
    Uint8List? downloadedIconData;
    try {
      print("Downloading image from: ${service.icon}");

      final response = await http.get(Uri.parse(service.icon));
      print("Response status: ${response.statusCode}");
      print("Response body length: ${response.bodyBytes.length}");

      if (response.statusCode == 200) {
        downloadedIconData = response.bodyBytes;
        print("Downloaded image size: ${downloadedIconData.length} bytes");
      }
    } catch (e) {
      print('Failed to download icon for ${service.identifier}: $e');
    }

    final model = ServiceModel(
      identifier: service.identifier,
      name: service.name,
      type: service.type,
      emails: service.emails,
      mainContact: service.mainContact,
      otherContacts: service.otherContacts,
      language: language,
      iconData: downloadedIconData,
    );

    print(
        "ServiceModel created with iconData length: ${model.iconData?.length}");

    return model;
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
