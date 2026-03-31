import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/utils/constants.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:mauritius_emergency_services/ui/widgets/chips/chip_status.dart';
import 'package:mauritius_emergency_services/ui/widgets/items/item_drawer.dart';
import 'package:mauritius_emergency_services/ui/widgets/texts/text_special_header.dart';
import 'package:url_launcher/url_launcher.dart';

class MesDrawerPrimary extends StatelessWidget {
  const MesDrawerPrimary({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current route path
    final currentRoute = GoRouter.of(
      context,
    ).routeInformationProvider.value.uri.path;
    return Padding(
      padding: const EdgeInsets.only(right: 56.0),
      child: Drawer(
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.only(right: 16.0),
          children: [
            const MesDrawerHeader(),
            MesDrawerItem(
              leadingIcon: const Icon(Icons.home_outlined),
              title: t.pages.home.title.capitalizeAll(),
              isSelected: HomeRoute.path == currentRoute,
              onTap: () {
                context.popAndGo(HomeRoute.path);
              },
            ),
            MesDrawerItem(
              leadingIcon: const Icon(Icons.call_outlined),
              title: t.pages.services.title.capitalizeAll(),
              isSelected: ServicesRoute.path == currentRoute,
              onTap: () {
                context.popAndGo(ServicesRoute.path);
              },
            ),
            MesDrawerItem(
              leadingIcon: const Icon(Icons.warning_amber_outlined),
              title: t.pages.alerts.title.capitalizeAll(),
              trailing: MesChipStatus(label: t.actions.is_new.capitalizeAll()),
              isSelected: AlertsRoute.path == currentRoute,
              onTap: () {
                context.popAndGo(AlertsRoute.path);
              },
            ),
            MesDrawerItem(
              leadingIcon: const Icon(Icons.cyclone_outlined),
              title: t.pages.cyclone.title.capitalizeAll(),
              isSelected: CycloneReportRoute.path == currentRoute,
              onTap: () {
                context.popAndGo(CycloneReportRoute.path);
              },
            ),
            MesDrawerItem(
              leadingIcon: const Icon(Icons.electric_bolt_outlined),
              title: t.pages.power_outages.title.capitalizeAll(),
              trailing: MesChipStatus(label: t.actions.is_new.capitalizeAll()),
              isSelected: OutagesRoute.path == currentRoute,
              onTap: () {
                context.popAndGo(OutagesRoute.path);
              },
            ),
            MesDrawerItem(
              leadingIcon: const Icon(Icons.brightness_4),
              title: t.pages.sun_moon_tides.title.capitalizeAll(),
              trailing: MesChipStatus(
                label: t.actions.coming_soon.capitalizeAll(),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
              onTap: () {},
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Divider(),
            ),
            MesDrawerItem(
              leadingIcon: const Icon(Icons.info_outline),
              title: t.pages.about.title.capitalizeAll(),
              onTap: () {
                context.push(AboutRoute.path);
              },
            ),
            MesDrawerItem(
              leadingIcon: const Icon(Icons.settings_outlined),
              title: t.pages.settings.title.capitalizeAll(),
              onTap: () {
                context.push(SettingsRoute.path);
              },
            ),
            // MesDrawerItem(
            //   leadingIcon: const Icon(Icons.brightness_4_outlined),
            //   title: t.pages.theme_selector.title.capitalizeAll(),
            //   isSelected: false,
            //   onTap: () {
            //     context.pop();
            //     showDialog<String>(
            //       context: context,
            //       builder: (BuildContext context) => const ThemeDialog(),
            //     );
            //   },
            // ),
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
                await launchUrl(emailLaunchUri);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MesDrawerHeader extends StatelessWidget {
  const MesDrawerHeader({super.key});

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
