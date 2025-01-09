// Returns a Duration based on the cyclone level
Duration getRotationSpeedFromCycloneLevel({required int level}) {
  switch (level) {
    case 1:
      return const Duration(seconds: 7); // Slowest
    case 2:
      return const Duration(seconds: 4);
    case 3:
      return const Duration(seconds: 2);
    case 4:
      return const Duration(seconds: 1); // Fastest
    default:
      return const Duration(seconds: 7); // Default speed
  }
}
