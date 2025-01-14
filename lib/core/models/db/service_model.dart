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
  final String icon;
  final String language;
  final List<String> emails;
  final int mainContact;

  @Property(type: PropertyType.intVector)
  final List<int> otherContacts;

  ServiceModel({
    this.id = 0,
    required this.identifier,
    required this.name,
    required this.type,
    required this.icon,
    required this.emails,
    required this.mainContact,
    required this.otherContacts,
    required this.language,
  });

  // Convert Service to ServiceModel
  factory ServiceModel.fromService(Service service, String language) {
    return ServiceModel(
      identifier: service.identifier,
      name: service.name,
      type: service.type,
      icon: service.icon,
      emails: service.emails,
      mainContact: service.mainContact,
      otherContacts: service.otherContacts,
      language: language,
    );
  }

  // Convert ServiceModel to Service
  Service toService() {
    return Service(
      identifier: identifier,
      name: name,
      type: type,
      icon: icon,
      emails: emails,
      mainContact: mainContact,
      otherContacts: otherContacts,
    );
  }
}
