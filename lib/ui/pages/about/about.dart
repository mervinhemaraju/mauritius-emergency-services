import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mauritius_emergency_services/core/models/about.dart';
import 'package:mauritius_emergency_services/core/providers/package_version.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_simple.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';
import 'package:mauritius_emergency_services/ui/utils/constants.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the package version provider
    final version = ref.watch(appVersion);

    // Load the version data
    final versionState = version.when(
      data: (version) => version,
      loading: () => "Loading...",
      error: (error, stackTrace) => "Unknown",
    );

    // Define the scaffold key
    final scaffoldKey = GlobalKey<ScaffoldState>();

    // Get the 'other' section items
    final otherSection = About.getOtherSection();

    // Push a version item
    otherSection.add(About(
      icon: Icons.info_outlined,
      title: "Version",
      body: versionState,
    ));

    // Return the view
    return Scaffold(
      extendBody: true,
      key: scaffoldKey,
      appBar: MesAppBar(
        title: "About",
        goBack: () => context.goBack(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 21.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _AboutHeader(),
              _AboutSection(
                title: "SUPPORT",
                section: About.getSupportSection(),
              ),
              _AboutSection(
                title: "OTHER",
                section: otherSection,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final List<About> section;
  final String title;

  const _AboutSection({required this.section, required this.title});

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Card(
      elevation: MesElevation.card,
      margin: EdgeInsets.all(8.0),
      surfaceTintColor: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              bottom: 8.0,
              top: 16.0,
            ),
            child: Text(
              title,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ...section.map(
            (about) => AboutSectionListItem(
              icon: about.icon,
              title: about.title,
              subtitle: about.body,
              onTap: () async {
                if (about.title.toLowerCase().startsWith("share")) {
                  Share.share(URI_MES_PLAYSTORE);
                } else {
                  if (about.url != null) {
                    await launchUrl(about.url!);
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class _AboutHeader extends StatelessWidget {
  const _AboutHeader();
  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Card(
      elevation: MesElevation.card,
      margin: EdgeInsets.all(8.0),
      surfaceTintColor: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              bottom: 8.0,
              top: 16.0,
            ),
            child: Text(
              "ABOUT",
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: SvgPicture.asset(
              width: 56,
              height: 56,
              AssetsManager.STATIC_MES,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
          ),
          AboutHeaderListItem(
            title: "Mervin Hemaraju",
            subtitle: "Lead Developer & Designer",
            background: theme.colorScheme.primaryContainer,
            foreground: theme.colorScheme.onPrimaryContainer,
            onTap: () async =>
                await launchUrl(Uri.parse(URI_DEVELOPER_WEBSITE)),
          ),
          AboutHeaderListItem(
            title: "Nick Foo Kune",
            subtitle: "Playstore Banner & Images",
            background: theme.colorScheme.tertiaryContainer,
            foreground: theme.colorScheme.onTertiaryContainer,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 32.0, bottom: 16.0, left: 8.0, right: 8.0),
            child: Text(
              "Developed with ❤ in 🇲🇺",
              style: theme.textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
