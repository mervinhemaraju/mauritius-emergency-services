import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/ui/utils/constants.dart';

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
        title: "Rate MES",
        body:
            "If you love the app, let us know in the Google Play Store and we can make it even better.",
        url: Uri.parse(
          URI_MES_PLAYSTORE,
        ),
      ),
      About(
        icon: Icons.share_outlined,
        title: "Share Mes",
        body: "Do not forget to share Mes with your friends and families.",
      )
    ];
  }

  static List<About> getOtherSection() {
    return <About>[
      About(
          icon: Icons.group_outlined,
          title: "About MES",
          body: "Check us out on our official website.",
          url: Uri.parse(
            URI_MES_WEBSITE,
          )),
      About(
          icon: Icons.code_outlined,
          title: "Developer API",
          body: "Application Program Interface (API) used in MES.",
          url: Uri.parse(
            URI_MES_API,
          )),
      About(
          icon: Icons.privacy_tip_outlined,
          title: "Privacy Policy",
          body: "View the privacy policy for Mes.",
          url: Uri.parse(
            URI_MES_PRIVACY_POLICY,
          )),
    ];
  }
}
