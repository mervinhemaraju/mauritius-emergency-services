// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsRepositoryHash() =>
    r'550f5a3b130bb9774a565a1eab4972404e5e8921';

/// See also [settingsRepository].
@ProviderFor(settingsRepository)
final settingsRepositoryProvider =
    AutoDisposeProvider<AppSettingsRepository>.internal(
  settingsRepository,
  name: r'settingsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingsRepositoryRef = AutoDisposeProviderRef<AppSettingsRepository>;
String _$mesSettingsNotifierHash() =>
    r'a1e8af32310171d1cadea39c67256c54d76c687f';

/// See also [MesSettingsNotifier].
@ProviderFor(MesSettingsNotifier)
final mesSettingsNotifierProvider =
    AutoDisposeNotifierProvider<MesSettingsNotifier, MesSettings>.internal(
  MesSettingsNotifier.new,
  name: r'mesSettingsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mesSettingsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MesSettingsNotifier = AutoDisposeNotifier<MesSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
