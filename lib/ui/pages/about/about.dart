import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mauritius_emergency_services/core/models/app/about.dart';
import 'package:mauritius_emergency_services/data/helpers/assets_manager.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/providers/package_version.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';
import 'package:mauritius_emergency_services/ui/theme/shapes.dart';
import 'package:mauritius_emergency_services/ui/utils/constants.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:mauritius_emergency_services/ui/widgets/appbars/appbar_primary.dart';
import 'package:mauritius_emergency_services/ui/widgets/items/item_list_about_header.dart';
import 'package:mauritius_emergency_services/ui/widgets/items/item_list_about_section.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Return the view
    return Scaffold(
      extendBody: true,
      appBar: MesAppBarPrimary(
        title: t.pages.about.title.capitalize(),
        goBack: () => context.goBack(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 21.0),
          child: Consumer(
            builder: (context, ref, child) {
              // Watch the package version provider
              final packageInfo = ref.watch(packageInfoProvider);

              // Load the version data
              final List<MesAbout> otherSection = packageInfo.when(
                data: (info) {
                  final otherSection = MesAbout.getOtherSection();
                  otherSection.add(
                    MesAbout(
                      icon: Icons.info_outlined,
                      title: t.pages.about.other_section.version_title
                          .capitalize(),
                      body: info.version,
                    ),
                  );
                  return otherSection;
                },
                loading: () => [],
                error: (error, stackTrace) => [],
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AboutHeader(),
                  AboutSection(
                    title: t.pages.about.support_section.title.toUpperCase(),
                    section: MesAbout.getSupportSection(),
                  ),
                  AboutSection(
                    title: t.pages.about.other_section.title.toUpperCase(),
                    section: otherSection,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  final List<MesAbout> section;
  final String title;

  const AboutSection({required this.section, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Card(
      elevation: MesElevation.card,
      margin: const EdgeInsets.all(8.0),
      surfaceTintColor: theme.colorScheme.surface,
      shape: MesShapes.card,
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
          const SizedBox(height: 16.0),
          // Convert map to ListView.builder for better performance
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: section.length,
            itemBuilder: (context, index) {
              final about = section[index];
              return AboutSectionListItem(
                key: ValueKey(about.title), // Add key for better reconciliation
                icon: about.icon,
                title: about.title,
                subtitle: about.body,
                onTap: about.launchAboutIntent,
              );
            },
          ),
        ],
      ),
    );
  }
}

class AboutHeader extends StatelessWidget {
  const AboutHeader({super.key});
  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Card(
      elevation: MesElevation.card,
      margin: const EdgeInsets.all(8.0),
      surfaceTintColor: theme.colorScheme.surface,
      shape: MesShapes.card,
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
              t.pages.about.header.title.toUpperCase(),
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
              AssetsManager.staticMes,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
          ),
          AboutHeaderListItem(
            title: t.pages.about.header.developer_name.capitalizeAll(),
            subtitle: t.pages.about.header.developer_title.capitalizeAll(),
            background: theme.colorScheme.primaryContainer,
            foreground: theme.colorScheme.onPrimaryContainer,
            onTap: () async => launchUrl(Uri.parse(URI_DEVELOPER_WEBSITE)),
          ),
          AboutHeaderListItem(
            title: t.pages.about.header.designer_name.capitalizeAll(),
            subtitle: t.pages.about.header.designer_title.capitalizeAll(),
            background: theme.colorScheme.tertiaryContainer,
            foreground: theme.colorScheme.onTertiaryContainer,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 32.0,
              bottom: 16.0,
              left: 8.0,
              right: 8.0,
            ),
            child: Text(
              t.pages.about.header.caption.capitalize(),
              style: theme.textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
