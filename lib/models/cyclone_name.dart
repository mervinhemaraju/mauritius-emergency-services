import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/cyclone_name.freezed.dart';
part '../generated/models/cyclone_name.g.dart';

@freezed
abstract class CycloneName with _$CycloneName {
  const factory CycloneName({
    required String name,
    required String gender,
    // FIXME(Find a fix for the JsonKey)
    @JsonKey(name: 'provided_by') required String providedBy,
    @JsonKey(name: 'named_by') required String namedBy,
  }) = _CycloneName;

  factory CycloneName.fromJson(Map<String, dynamic> json) =>
      _$CycloneNameFromJson(json);
}
