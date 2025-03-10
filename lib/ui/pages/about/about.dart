import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mauritius_emergency_services/models/about.dart';
import 'package:mauritius_emergency_services/providers/package_version.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/components/appbar_simple.dart';
import 'package:mauritius_emergency_services/ui/components/list_items.dart';
import 'package:mauritius_emergency_services/ui/utils/constants.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Return the view
    return Scaffold(
      extendBody: true,
      appBar: MesAppBar(
        title: t.pages.about.title.capitalize(),
        goBack: () => context.goBack(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 21.0),
          child: Consumer(builder: (context, ref, child) {
            // Watch the package version provider
            final packageInfo = ref.watch(packageInfoProvider);

            // Load the version data
            final List<About> otherSection = packageInfo.when(
              data: (info) {
                final otherSection = About.getOtherSection();
                otherSection.add(About(
                  icon: Icons.info_outlined,
                  title: t.pages.about.other_section.version_title.capitalize(),
                  body: info.version,
                ));
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
                  section: About.getSupportSection(),
                ),
                AboutSection(
                  title: t.pages.about.other_section.title.toUpperCase(),
                  section: otherSection,
                ),
                const DisclaimerSection(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class DisclaimerSection extends StatelessWidget {
  const DisclaimerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Card(
      elevation: MesElevation.card,
      margin: const EdgeInsets.all(8.0),
      surfaceTintColor: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16.0,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              top: 16.0,
            ),
            child: Text(
              t.pages.about.disclaimer.title.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              bottom: 8.0,
            ),
            child: Text(
              t.pages.about.disclaimer.message_1(
                app_name_short: t.app.short_name.toUpperCase(),
              ),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              bottom: 8.0,
            ),
            child: Text(
              t.pages.about.disclaimer.message_2,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  final List<About> section;
  final String title;

  const AboutSection({
    super.key,
    required this.section,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Card(
      elevation: MesElevation.card,
      margin: const EdgeInsets.all(8.0),
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
  const AboutHeader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return Card(
      elevation: MesElevation.card,
      margin: const EdgeInsets.all(8.0),
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
              AssetsManager.STATIC_MES,
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
            onTap: () async =>
                await launchUrl(Uri.parse(URI_DEVELOPER_WEBSITE)),
          ),
          AboutHeaderListItem(
            title: t.pages.about.header.designer_name.capitalizeAll(),
            subtitle: t.pages.about.header.designer_title.capitalizeAll(),
            background: theme.colorScheme.tertiaryContainer,
            foreground: theme.colorScheme.onTertiaryContainer,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 32.0, bottom: 16.0, left: 8.0, right: 8.0),
            child: Text(
              t.pages.about.header.caption.capitalize(),
              style: theme.textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
