import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/cyclone_names.freezed.dart';
part '../generated/models/cyclone_names.g.dart';

@freezed
abstract class CycloneNames with _$CycloneNames {
  const factory CycloneNames({
    required String name,
    required String gender,
    // FIXME(Find a fix for the JsonKey)
    @JsonKey(name: 'provided_by') required String providedBy,
    @JsonKey(name: 'named_by') required String namedBy,
  }) = _CycloneNames;

  factory CycloneNames.fromJson(Map<String, dynamic> json) =>
      _$CycloneNamesFromJson(json);
}
