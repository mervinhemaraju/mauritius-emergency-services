import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mauritius_emergency_services/data/helpers/assets_manager.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';

part '../../../generated/core/models/app/welcome.freezed.dart';
part '../../../generated/core/models/app/welcome.g.dart';

@freezed
abstract class MesWelcome with _$MesWelcome {
  /*
    This is the Welcome model class which 
    provides a static list of data for the
    welcome class carousel slider 
  */
  const factory MesWelcome({
    required String asset,
    required String title,
    required String subtitle,
  }) = _MesWelcome;

  factory MesWelcome.fromJson(Map<String, dynamic> json) =>
      _$MesWelcomeFromJson(json);

  static List<MesWelcome> get welcomeItems => [
    MesWelcome(
      asset: AssetsManager.staticSmartphoneData,
      title: t.pages.welcome.carousel.title_1,
      subtitle: t.pages.welcome.carousel.subtitle_1,
    ),
    MesWelcome(
      asset: AssetsManager.staticStorm,
      title: t.pages.welcome.carousel.title_2,
      subtitle: t.pages.welcome.carousel.subtitle_2,
    ),
    MesWelcome(
      asset: AssetsManager.staticPolice,
      title: t.pages.welcome.carousel.title_3,
      subtitle: t.pages.welcome.carousel.subtitle_3,
    ),
    MesWelcome(
      asset: AssetsManager.staticSos,
      title: t.pages.welcome.carousel.title_4,
      subtitle: t.pages.welcome.carousel.subtitle_4,
    ),
    MesWelcome(
      asset: AssetsManager.staticOffline,
      title: t.pages.welcome.carousel.title_5,
      subtitle: t.pages.welcome.carousel.subtitle_5,
    ),
  ];
}
