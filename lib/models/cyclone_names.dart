import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/cyclone_names.freezed.dart';
part '../generated/models/cyclone_names.g.dart';

@freezed
abstract class CycloneNames with _$CycloneNames {
  const factory CycloneNames({
    required String name,
    required String gender,
    required String providedBy,
    required String namedBy,
  }) = _CycloneNames;

  factory CycloneNames.fromJson(Map<String, dynamic> json) =>
      _$CycloneNamesFromJson(json);
}
