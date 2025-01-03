import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mauritius_emergency_services/core/models/about.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/ui/components/appbar.dart';
import 'package:mauritius_emergency_services/ui/settings/extensions.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: MesAppBar(
        title: "About",
        goBack: () => context.goBack(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AboutHeader(),
            _AboutSection(
              title: "SUPPORT",
              section: About.getSupportSection(),
            ),
            _AboutSection(
              title: "OTHER",
              section: About.getOtherSection(),
            ),
          ],
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
    return Card(
      elevation: MesElevation.card,
      margin: EdgeInsets.all(8.0),
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(height: 16.0),
            ...section.map(
              (about) => ListTile(
                leading: Icon(
                  about.icon,
                  // size: 48,
                ),
                title: Text(about.title),
                subtitle: Text(about.body),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AboutHeader extends StatelessWidget {
  const _AboutHeader();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: MesElevation.card,
      margin: EdgeInsets.all(8.0),
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "ABOUT",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: SvgPicture.asset(
                width: 56,
                height: 56,
                AssetsManager.STATIC_MES,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.supervised_user_circle,
                size: 48,
              ),
              title: Text("Mervin Hemaraju"),
              subtitle: Text("Lead Developer & Designer"),
            ),
            ListTile(
              leading: Icon(
                Icons.supervised_user_circle,
                size: 48,
              ),
              title: Text("Nick Foo Kune"),
              subtitle: Text("Lead Developer & Designer"),
            ),
            SizedBox(
              height: 24.0,
            ),
            Text(
              "Developed with ❤ in 🇲🇺",
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
