import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/core/models/service/service.freezed.dart';
part '../../../generated/core/models/service/service.g.dart';

@freezed
abstract class MesService with _$MesService {
  const factory MesService({
    @Default("") String identifier,
    @Default("") String name,
    @Default("") String type,
    @Default("") String icon,
    @Default([]) List<String> emails,
    @JsonKey(name: 'main_contact') @Default(0) int mainContact,
    @JsonKey(name: 'other_contacts') @Default([]) List<int> otherContacts,
    @JsonKey(includeFromJson: false, includeToJson: false) Uint8List? iconData,
  }) = _MesService;

  const MesService._();

  factory MesService.fromJson(Map<String, dynamic> json) =>
      _$MesServiceFromJson(json);

  // Custom getters
  bool get hasExtraContacts => emails.isNotEmpty || otherContacts.isNotEmpty;

  bool get isTollFree =>
      mainContact.toString().startsWith('800') ||
      mainContact.toString().length < 5;
}
