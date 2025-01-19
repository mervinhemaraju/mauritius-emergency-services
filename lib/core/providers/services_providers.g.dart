// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$servicesHash() => r'510543d9ad81c608776f21793c7280558d2f9da9';

/// See also [services].
@ProviderFor(services)
final servicesProvider = AutoDisposeFutureProvider<List<Service>>.internal(
  services,
  name: r'servicesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$servicesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ServicesRef = AutoDisposeFutureProviderRef<List<Service>>;
String _$emergencyServicesHash() => r'b868a618872bb47beeff944d221b54a1d3ed8efb';

/// See also [emergencyServices].
@ProviderFor(emergencyServices)
final emergencyServicesProvider =
    AutoDisposeFutureProvider<Pair<Service, List<Service>>>.internal(
  emergencyServices,
  name: r'emergencyServicesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$emergencyServicesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmergencyServicesRef
    = AutoDisposeFutureProviderRef<Pair<Service, List<Service>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
