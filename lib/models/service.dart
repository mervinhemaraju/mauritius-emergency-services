import 'dart:typed_data';

class Service {
  // Define the vars
  final String identifier;
  final String name;
  final String type;
  final String icon;
  final List<String> emails;
  final int mainContact;
  final List<int> otherContacts;
  final Uint8List? iconData;

  // Define the const
  const Service({
    this.identifier = "",
    this.name = "",
    this.type = "",
    this.icon = "",
    this.emails = const [],
    this.mainContact = 0,
    this.otherContacts = const [],
    this.iconData,
  });

  // Checks whether the service has extra contacts other than the main one
  bool get hasExtraContacts => emails.isNotEmpty || otherContacts.isNotEmpty;

  // Checks whether the main contact is toll-free
  bool get isTollFree =>
      mainContact.toString().startsWith('800') ||
      mainContact.toString().length < 5;

  // Converts the Service object to JSON
  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'name': name,
      'type': type,
      'icon': icon,
      'emails': emails,
      'main_contact': mainContact,
      'other_contacts': otherContacts,
    };
  }

  // Converts a JSON object to a Service object
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      identifier: json['identifier'],
      name: json['name'],
      type: json['type'],
      icon: json['icon'],
      emails: List<String>.from(json['emails']),
      mainContact: json['main_contact'],
      otherContacts: List<int>.from(json['other_contacts']),
    );
  }
}

// TODO(Test the below)
// import 'dart:typed_data';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part '../generated/models/service.freezed.dart';
// part '../generated/models/service.g.dart';

// @freezed
// abstract class Service with _$Service {
//   const factory Service({
//     @Default("") String identifier,
//     @Default("") String name,
//     @Default("") String type,
//     @Default("") String icon,
//     @Default([]) List<String> emails,
//     @Default(0) int mainContact,
//     @Default([]) List<int> otherContacts,
//     @JsonKey(includeFromJson: false, includeToJson: false) Uint8List? iconData,
//   }) = _Service;

//   const Service._();

//   factory Service.fromJson(Map<String, dynamic> json) =>
//       _$ServiceFromJson(json);

//   // Custom getters
//   bool get hasExtraContacts => emails.isNotEmpty || otherContacts.isNotEmpty;

//   bool get isTollFree =>
//       mainContact.toString().startsWith('800') ||
//       mainContact.toString().length < 5;
// }
