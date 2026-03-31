import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/core/models/cyclone/cyclone_name.freezed.dart';
part '../../../generated/core/models/cyclone/cyclone_name.g.dart';

@freezed
abstract class MesCycloneName with _$MesCycloneName {
  const factory MesCycloneName({
    required String name,
    required String gender,
    @JsonKey(name: 'provided_by') required String providedBy,
  }) = _MesCycloneName;

  factory MesCycloneName.fromJson(Map<String, dynamic> json) =>
      _$MesCycloneNameFromJson(json);
}
