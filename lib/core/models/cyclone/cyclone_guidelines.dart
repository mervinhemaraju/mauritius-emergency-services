import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/core/models/cyclone/cyclone_guidelines.freezed.dart';
part '../../../generated/core/models/cyclone/cyclone_guidelines.g.dart';

@freezed
abstract class MesCycloneGuidelines with _$MesCycloneGuidelines {
  const factory MesCycloneGuidelines({
    required int level,
    required String description,
    required List<String> precautions,
  }) = _MesCycloneGuidelines;

  factory MesCycloneGuidelines.fromJson(Map<String, dynamic> json) =>
      _$MesCycloneGuidelinesFromJson(json);
}
