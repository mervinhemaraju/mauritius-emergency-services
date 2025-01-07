import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/ui/components/widgets.dart';
import 'package:mauritius_emergency_services/ui/pages/theme.dart';
import 'package:pair/pair.dart';
import 'package:url_launcher/url_launcher.dart';

class MesDrawer extends StatelessWidget {
  const MesDrawer({
    super.key,
  });

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

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
          padding: EdgeInsets.only(right: 16.0),
          children: [
            MesDrawerHeader(),
            MesDrawerItem(
              leadingIcon: Icon(Icons.home_outlined),
              title: 'Home',
              isSelected: HomeRoute.path == currentRoute,
              onTap: () {
                Navigator.pop(context);
                context.go(HomeRoute.path);
              },
            ),
            MesDrawerItem(
                leadingIcon: Icon(Icons.call_outlined),
                title: 'Services',
                isSelected: ServicesRoute.path == currentRoute,
                onTap: () {
                  Navigator.pop(context);
                  context.go(ServicesRoute.path);
                }),
            MesDrawerItem(
              leadingIcon: Icon(Icons.cyclone_outlined),
              title: 'Cyclone Report',
              isSelected: CycloneReportRoute.path == currentRoute,
              onTap: () {
                Navigator.pop(context);
                context.go(CycloneReportRoute.path);
              },
            ),
            MesDrawerItem(
                leadingIcon: Icon(Icons.supervised_user_circle_outlined),
                title: 'Vicinity Alerts',
                isSelected: false,
                trailing: MesBadge(label: "Coming Soon"),
                onTap: () {}),
            MesDrawerItem(
              leadingIcon: Icon(Icons.info_outline),
              title: 'About',
              isSelected: false,
              onTap: () {
                context.push(AboutRoute.path);
              },
            ),
            MesDrawerItem(
                leadingIcon: Icon(Icons.settings_outlined),
                title: 'Settings',
                isSelected: false,
                onTap: () {
                  context.push(SettingsRoute.path);
                }),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Divider(),
            ),
            MesDrawerItem(
              leadingIcon: Icon(Icons.brightness_4_outlined),
              title: 'Theme',
              isSelected: false,
              onTap: () {
                context.pop();
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => ThemeDialog(),
                );
              },
            ),
            MesDrawerItem(
                leadingIcon: Icon(Icons.email_outlined),
                title: 'Contact Us',
                isSelected: false,
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.open_in_new_outlined),
                ),
                onTap: () {
                  // FIXME(Fix this email launcher)
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'our.email@gmail.com',
                    queryParameters: {
                      'subject': 'CallOut user Profile',
                      'body': "Hello, I'm a user of CallOut app",
                    },
                  );
                  _launchUrl(emailLaunchUri);
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
      selectedColor: Theme.of(context).colorScheme.primary,
      selectedTileColor: Theme.of(context).colorScheme.surfaceTint,
      leading: leadingIcon,
      title: Text(title),
      trailing: trailing,
      shape: RoundedRectangleBorder(
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
  static const List<Pair<String, String>> _headerItems = [
    Pair('M', 'auritius'),
    Pair('E', 'mergency'),
    Pair('S', 'ervices'),
  ];

  const MesDrawerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _headerItems
            .map(
              (item) => SpecialHeaderTitle(
                leadingCharacter: item.key,
                title: item.value,
              ),
            )
            .toList(),
      ),
    );
  }
}
