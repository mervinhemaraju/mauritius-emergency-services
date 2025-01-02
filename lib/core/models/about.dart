import 'package:flutter/material.dart';

class About {
  final IconData icon;
  final String title;
  final String body;

  About({
    required this.icon,
    required this.title,
    required this.body,
  });

  static List<About> getSupportSection() {
    return <About>[
      About(
        icon: Icons.star_outline,
        title: "Rate MES",
        body:
            "If you love the app, let us know in the Google Play Store and we can make it even better.",
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
      ),
      About(
        icon: Icons.code_outlined,
        title: "Developer API",
        body: "Application Program Interface (API) used in MES.",
      ),
      About(
        icon: Icons.privacy_tip_outlined,
        title: "Privacy Policy",
        body: "View the privacy policy for Mes.",
      ),
      About(
        icon: Icons.info_outlined,
        title: "Version",
        // TODO(Add the version here)
        body: "to_be_added",
      )
    ];
  }
}
