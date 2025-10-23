import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/service.freezed.dart';
part '../generated/models/service.g.dart';

@freezed
abstract class Service with _$Service {
  const factory Service({
    @Default("") String identifier,
    @Default("") String name,
    @Default("") String type,
    @Default("") String icon,
    @Default([]) List<String> emails,
    // FIXME(Find a fix for the JsonKey)
    @JsonKey(name: 'main_contact') @Default(0) int mainContact,
    @JsonKey(name: 'other_contacts') @Default([]) List<int> otherContacts,
    @JsonKey(includeFromJson: false, includeToJson: false) Uint8List? iconData,
  }) = _Service;

  const Service._();

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  // Custom getters
  bool get hasExtraContacts => emails.isNotEmpty || otherContacts.isNotEmpty;

  bool get isTollFree =>
      mainContact.toString().startsWith('800') ||
      mainContact.toString().length < 5;
}
