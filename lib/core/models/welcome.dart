import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/gen/strings.g.dart';

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
      title: t.pages.welcome.carousel.title_1,
      subtitle: t.pages.welcome.carousel.subtitle_1,
    ),
    Welcome(
      asset: AssetsManager.STATIC_STORM,
      title: t.pages.welcome.carousel.title_2,
      subtitle: t.pages.welcome.carousel.subtitle_2,
    ),
    Welcome(
      asset: AssetsManager.STATIC_POLICE,
      title: t.pages.welcome.carousel.title_3,
      subtitle: t.pages.welcome.carousel.subtitle_3,
    ),
    Welcome(
      asset: AssetsManager.STATIC_SOS,
      title: t.pages.welcome.carousel.title_4,
      subtitle: t.pages.welcome.carousel.subtitle_4,
    ),
    Welcome(
      asset: AssetsManager.STATIC_OFFLINE,
      title: t.pages.welcome.carousel.title_5,
      subtitle: t.pages.welcome.carousel.subtitle_5,
    ),
  ];
}
