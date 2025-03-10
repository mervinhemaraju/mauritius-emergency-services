import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/utils/constants.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class About {
  final IconData icon;
  final String title;
  final String body;
  final Uri? url;

  About({
    required this.icon,
    required this.title,
    required this.body,
    this.url,
  });

  static List<About> getSupportSection() {
    return <About>[
      About(
        icon: Icons.star_outline,
        title: t.pages.about.support_section
            .rate_app_title(app_name_short: t.app.short_name.toUpperCase())
            .capitalizeAll(),
        body: t.pages.about.support_section.rate_app_subtitle.capitalize(),
        url: Uri.parse(
          URI_MES_PLAYSTORE,
        ),
      ),
      About(
        icon: Icons.share_outlined,
        title: t.pages.about.support_section
            .share_app_title(app_name_short: t.app.short_name.toUpperCase())
            .capitalizeAll(),
        body: t.pages.about.support_section
            .share_app_subtitle(app_name_short: t.app.short_name.toUpperCase())
            .capitalize(),
      )
    ];
  }

  static List<About> getOtherSection() {
    return <About>[
      About(
          icon: Icons.group_outlined,
          title: t.pages.about.other_section
              .about_app_title(app_name_short: t.app.short_name.toUpperCase())
              .capitalizeAll(),
          body: t.pages.about.other_section.about_app_subtitle.capitalize(),
          url: Uri.parse(
            URI_MES_WEBSITE,
          )),
      About(
          icon: Icons.code_outlined,
          title:
              t.pages.about.other_section.developer_api_title.capitalizeAll(),
          body: t.pages.about.other_section.about_app_subtitle.capitalize(),
          url: Uri.parse(
            URI_MES_API,
          )),
      About(
          icon: Icons.privacy_tip_outlined,
          title:
              t.pages.about.other_section.privacy_policy_title.capitalizeAll(),
          body: t.pages.about.other_section
              .privacy_policy_subtitle(
                  app_name_short: t.app.short_name.toUpperCase())
              .capitalizeAll(),
          url: Uri.parse(
            URI_MES_PRIVACY_POLICY,
          )),
    ];
  }
}
