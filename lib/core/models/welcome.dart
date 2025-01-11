import 'package:mauritius_emergency_services/data/assets_manager.dart';

class Welcome {
  final String asset;
  final String title;
  final String subtitle;

  const Welcome({
    required this.asset,
    required this.title,
    required this.subtitle,
  });

  static List<Welcome> welcomeItems = [
    Welcome(
      asset: AssetsManager.STATIC_SMARTPHONE_DATA,
      title: "Services List",
      subtitle:
          "Get a list of all emergency and non-emergency services for Mauritius right in your phone.",
    ),
    Welcome(
      asset: AssetsManager.STATIC_STORM,
      title: "Cyclone Alerts",
      subtitle:
          "Get notified of cyclone warnings and read the cyclone guidelines live from your phone.",
    ),
    Welcome(
      asset: AssetsManager.STATIC_POLICE,
      title: "Emergency Actions",
      subtitle:
          "Get a dedicated corder on your dashboard just for emergency services.",
    ),
    Welcome(
      asset: AssetsManager.STATIC_SOS,
      title: "SOS",
      subtitle:
          "Call for urgent help right from the app using the big red button.",
    ),
    Welcome(
      asset: AssetsManager.STATIC_OFFLINE,
      title: "Offline Availability",
      subtitle:
          "Connect once to the internet and get all your services available to you offline.",
    ),
  ];
}
