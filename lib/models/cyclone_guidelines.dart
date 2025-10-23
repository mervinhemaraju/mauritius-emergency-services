import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/models/cyclone_guidelines.freezed.dart';
part '../generated/models/cyclone_guidelines.g.dart';

@freezed
abstract class CycloneGuidelines with _$CycloneGuidelines {
  const factory CycloneGuidelines({
    required int level,
    required String description,
    required List<String> precautions,
  }) = _CycloneGuidelines;

  factory CycloneGuidelines.fromJson(Map<String, dynamic> json) =>
      _$CycloneGuidelinesFromJson(json);
}
