import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';

part '../generated/models/welcome.freezed.dart';
part '../generated/models/welcome.g.dart';

@freezed
abstract class Welcome with _$Welcome {
  /*
    This is the Welcome model class which 
    provides a static list of data for the
    welcome class carousel slider 
  */
  const factory Welcome({
    required String asset,
    required String title,
    required String subtitle,
  }) = _Welcome;

  factory Welcome.fromJson(Map<String, dynamic> json) =>
      _$WelcomeFromJson(json);

  static List<Welcome> get welcomeItems => [
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
