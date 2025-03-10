import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mauritius_emergency_services/models/locale.dart';
import 'package:mauritius_emergency_services/models/service.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/components/widgets.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

// The MES Drawer Item
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

// A search item
class SearchItem extends StatelessWidget {
  final Service service;
  final void Function(Service service) onTap;

  const SearchItem({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(service.name),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(service.mainContact.toString()),
      ),
      trailing: const Icon(Icons.open_in_new),
      onTap: () {
        onTap(service);
      },
    );
  }
}

// The about header list item
class AboutHeaderListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color background;
  final Color foreground;
  final Function()? onTap;

  const AboutHeaderListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.background,
    required this.foreground,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          size: 28,
          color: foreground,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
      onTap: onTap,
    );
  }
}

// The about section list item
class AboutSectionListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Function() onTap;

  const AboutSectionListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      minVerticalPadding: 12.0,
      leading: Icon(
        icon,
        color: theme.colorScheme.primary,
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.secondary,
        ),
      ),
      onTap: onTap,
    );
  }
}

// The emergency tile item
class MesEmergencyTileItem extends StatelessWidget {
  final Service service;
  final Function()? onTap;

  const MesEmergencyTileItem({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 240,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                service.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: service.iconData.loadImage(
                    networkImageUrl: service.icon,
                    memoryPlaceholderImage: AssetsManager.ANIMATED_LOADING,
                    size: 48),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// The settings list item
class SettingsItem extends StatelessWidget {
  final IconData icon;
  final Widget? trailing;
  final String title;
  final String subtitle;
  final Function()? onTap;

  const SettingsItem({
    super.key,
    this.trailing,
    this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      leading: Icon(
        icon,
        color: theme.colorScheme.primary,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

// The exapndable dismissible service list item
class ExpandableDismissibleService extends StatelessWidget {
  final Service service;
  final bool isExpanded;
  final Color dismissibleBackgroundColor;
  final Function() onToggle;
  final Function(Color) toggleDismissibleBackgroundColor;

  const ExpandableDismissibleService({
    super.key,
    required this.service,
    required this.dismissibleBackgroundColor,
    required this.isExpanded,
    required this.onToggle,
    required this.toggleDismissibleBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: Key(service.identifier),
      confirmDismiss: (direction) async {
        // Send haptic feedback to user
        HapticFeedback.lightImpact();

        // Navigate to pre call
        context.navigateToPreCall(service, service.mainContact.toString());

        // Return false to prevent tiel from dismiss
        return false;
      },
      onUpdate: (details) => {
        if (details.reached)
          {
            toggleDismissibleBackgroundColor(
              theme.colorScheme.primary,
            )
          }
        else
          {
            toggleDismissibleBackgroundColor(
              theme.colorScheme.secondary,
            )
          }
      },
      direction: DismissDirection.endToStart,
      dismissThresholds: const {DismissDirection.endToStart: 0.5},
      background: Container(
        alignment: Alignment.centerRight,
        color: dismissibleBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 21.0),
          child: Icon(
            Icons.call_outlined,
            color: theme.colorScheme.onSecondary,
          ),
        ),
      ),
      child: Container(
        color: isExpanded
            ? theme.colorScheme.surfaceContainerHigh
            : theme.colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              leading: service.iconData.loadImage(
                  networkImageUrl: service.icon,
                  memoryPlaceholderImage: AssetsManager.ANIMATED_LOADING),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  service.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              subtitle: Row(
                children: [
                  Text(service.mainContact.toString(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.secondary,
                      )),
                  if (service.isTollFree) ...[
                    const SizedBox(width: 12.0),
                    MesChip(label: t.actions.toll_free.capitalizeAll())
                  ],
                ],
              ),
              trailing: IconButton(
                onPressed: onToggle,
                icon: Icon(
                  isExpanded
                      ? Icons.arrow_drop_up_outlined
                      : Icons.arrow_drop_down_outlined,
                ),
              ),
              onTap: onToggle,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: ClipRect(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isExpanded ? 1.0 : 0.0,
                  child: Container(
                    height: isExpanded ? null : 0.0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    child: service.hasExtraContacts
                        ? _ExtraContactView(
                            emails: service.emails,
                            otherContacts: service.otherContacts,
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiary,
                            onTap: (contact) {
                              if (contact.toString().isNumeric()) {
                                context.navigateToPreCall(
                                    service, contact.toString());
                              } else {
                                // Build the uri
                                final uri = Uri(
                                  scheme: 'mailto',
                                  path: contact.toString(),
                                );

                                launchUrl(uri);
                              }
                            })
                        : Text(
                            t.messages.info.no_other_contacts.capitalizeAll()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ExtraContactView({
    required final List<String> emails,
    required final List<int> otherContacts,
    required final Color backgroundColor,
    required final Function(dynamic) onTap,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(t.messages.info.other_contacts.capitalizeAll()),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0, // horizontal spacing between badges
            runSpacing: 8.0, // vertical spacing between lines
            children: [
              ...emails.map(
                (email) => MesChip(
                  icon: Icons.email_outlined,
                  label: email,
                  padding: const EdgeInsets.all(8.0),
                  backgroundColor: backgroundColor,
                  onTap: () => onTap(email),
                ),
              ),
              ...otherContacts.map(
                (contact) => MesChip(
                  icon: Icons.phone_outlined,
                  label: contact.toString(),
                  padding: const EdgeInsets.all(8.0),
                  backgroundColor: backgroundColor,
                  onTap: () => onTap(contact),
                ),
              ),
            ],
          ),
        ],
      );
}

// The cyclone news item
class CycloneNewsItem extends StatelessWidget {
  final String news;

  const CycloneNewsItem({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: MesElevation.card,
      child: Container(
        width: 260.0,
        padding: const EdgeInsets.all(8.0),
        child: Text(news),
      ),
    );
  }
}

// The welcome page's carousel item
class WelcomeCarouselItem extends StatelessWidget {
  final String asset;
  final String title;
  final String subtitle;

  const WelcomeCarouselItem({
    super.key,
    required this.asset,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            child: Image.asset(
              asset,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
              letterSpacing: 3.0,
            ),
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 21.0,
        )
      ],
    );
  }
}

// Simple Service Item
class SimpleServiceItem extends StatelessWidget {
  const SimpleServiceItem({
    super.key,
    required this.isSelected,
    required this.service,
    required this.onServiceSelected,
  });

  final bool isSelected;
  final Service service;
  final Function(Service service) onServiceSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      selectedColor: Theme.of(context).colorScheme.onTertiary,
      selectedTileColor: Theme.of(context).colorScheme.tertiary,
      title: Text(service.name),
      subtitle: Text(service.mainContact.toString()),
      trailing: isSelected
          ? Icon(
              Icons.check_outlined,
              color: Theme.of(context).colorScheme.onTertiary,
            )
          : null,
      onTap: () {
        onServiceSelected(service);
      },
    );
  }
}

// Language selector item
class LanguageSelectorItem extends StatelessWidget {
  final bool isSelected;
  final MesLocale locale;
  final Function(MesLocale) onTap;

  const LanguageSelectorItem({
    super.key,
    required this.isSelected,
    required this.locale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      selectedColor: Theme.of(context).colorScheme.onTertiary,
      selectedTileColor: Theme.of(context).colorScheme.tertiary,
      title: Text(
        t.others.language[locale.name.toString()]?.capitalize() ??
            t.others.language.entries.first.value.capitalize(),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_outlined,
              color: Theme.of(context).colorScheme.onTertiary,
            )
          : null,
      onTap: () {
        // Update the locale
        onTap(locale);
      },
    );
  }
}
