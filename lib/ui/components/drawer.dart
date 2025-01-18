import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/gen/strings.g.dart';
import 'package:mauritius_emergency_services/ui/components/widgets.dart';
import 'package:mauritius_emergency_services/ui/pages/theme_selector/theme.dart';
import 'package:mauritius_emergency_services/ui/utils/constants.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class MesDrawer extends StatelessWidget {
  const MesDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get the current route path
    final currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.path;
    return Padding(
      padding: const EdgeInsets.only(right: 56.0),
      child: Drawer(
        width: double.infinity,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: const EdgeInsets.only(right: 16.0),
          children: [
            const MesDrawerHeader(),
            MesDrawerItem(
              leadingIcon: const Icon(Icons.home_outlined),
              title: t.pages.home.title.capitalizeAll(),
              isSelected: HomeRoute.path == currentRoute,
              onTap: () {
                Navigator.pop(context);
                context.go(HomeRoute.path);
              },
            ),
            MesDrawerItem(
                leadingIcon: const Icon(Icons.call_outlined),
                title: t.pages.services.title.capitalizeAll(),
                isSelected: ServicesRoute.path == currentRoute,
                onTap: () {
                  Navigator.pop(context);
                  context.go(ServicesRoute.path);
                }),
            MesDrawerItem(
              leadingIcon: const Icon(Icons.cyclone_outlined),
              title: t.pages.cyclone.title.capitalizeAll(),
              isSelected: CycloneReportRoute.path == currentRoute,
              onTap: () {
                Navigator.pop(context);
                context.go(CycloneReportRoute.path);
              },
            ),
            MesDrawerItem(
                leadingIcon: const Icon(Icons.supervised_user_circle_outlined),
                title: t.pages.vicinity_alerts.title.capitalizeAll(),
                isSelected: false,
                trailing: MesChip(label: t.actions.coming_soon.capitalizeAll()),
                onTap: () {}),
            MesDrawerItem(
              leadingIcon: const Icon(Icons.info_outline),
              title: t.pages.about.title.capitalizeAll(),
              isSelected: false,
              onTap: () {
                context.push(AboutRoute.path);
              },
            ),
            MesDrawerItem(
                leadingIcon: const Icon(Icons.settings_outlined),
                title: t.pages.settings.title.capitalizeAll(),
                isSelected: false,
                onTap: () {
                  context.push(SettingsRoute.path);
                }),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Divider(),
            ),
            MesDrawerItem(
              leadingIcon: const Icon(Icons.brightness_4_outlined),
              title: t.pages.theme_selector.title.capitalizeAll(),
              isSelected: false,
              onTap: () {
                context.pop();
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => const ThemeDialog(),
                );
              },
            ),
            MesDrawerItem(
                leadingIcon: const Icon(Icons.email_outlined),
                title: t.actions.contact_us.capitalizeAll(),
                isSelected: false,
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.open_in_new_outlined),
                ),
                onTap: () async {
                  final Uri emailLaunchUri = Uri.parse(URI_MES_CONTACT_US);
                  launchUrl(emailLaunchUri);
                }),
          ],
        ),
      ),
    );
  }
}

class MesDrawerItem extends StatelessWidget {
  final bool isSelected;
  final Icon leadingIcon;
  final String title;
  final void Function() onTap;
  final Widget? trailing;

  const MesDrawerItem({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      selectedColor: Theme.of(context).colorScheme.onPrimaryContainer,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
      leading: leadingIcon,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: trailing,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(25), // Apply stadium effect
          left: Radius.zero, // No effect on the left
        ),
      ),
      onTap: onTap,
    );
  }
}

class MesDrawerHeader extends StatelessWidget {
  const MesDrawerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: t.app.name
              .getStyleHeaderName()
              .map(
                (item) => SpecialHeaderTitle(
                  leadingCharacter: item.key,
                  title: item.value,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
