import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mauritius_emergency_services/data/helpers/assets_manager.dart';
import 'package:mauritius_emergency_services/models/service/service.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';
import 'package:mauritius_emergency_services/ui/widgets/chips/chip_status.dart';
import 'package:url_launcher/url_launcher.dart';

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
          {toggleDismissibleBackgroundColor(theme.colorScheme.primary)}
        else
          {toggleDismissibleBackgroundColor(theme.colorScheme.secondary)},
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
            ? theme.colorScheme.tintedSurface(level: 48.0)
            : theme.colorScheme.tintedSurface(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              leading: service.iconData.loadImage(
                networkImageUrl: service.icon,
                memoryPlaceholderImage: AssetsManager.animatedLoading,
              ),
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
                  Text(
                    service.mainContact.toString(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  if (service.isTollFree) ...[
                    const SizedBox(width: 12.0),
                    MesChipStatus(label: t.actions.toll_free.capitalizeAll()),
                  ],
                ],
              ),
              trailing: !service.hasExtraContacts
                  ? null
                  : Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Badge(
                          label: isExpanded
                              ? null
                              : Text(
                                  (service.otherContacts.length +
                                          service.emails.length)
                                      .toString(),
                                ),

                          textColor: Theme.of(context).colorScheme.onTertiary,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.tertiary,
                        ),
                        Icon(
                          isExpanded
                              ? Icons.arrow_drop_up_outlined
                              : Icons.arrow_drop_down_outlined,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ],
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
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.tertiary,
                            onTap: (contact) {
                              if (contact.toString().isNumeric()) {
                                context.navigateToPreCall(
                                  service,
                                  contact.toString(),
                                );
                              } else {
                                // Build the uri
                                final uri = Uri(
                                  scheme: 'mailto',
                                  path: contact.toString(),
                                );

                                launchUrl(uri);
                              }
                            },
                          )
                        : Text(
                            t.messages.info.no_other_contacts.capitalizeAll(),
                          ),
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
  }) => Column(
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
            (email) => MesChipStatus(
              icon: Icons.email_outlined,
              label: email,
              padding: const EdgeInsets.all(8.0),
              backgroundColor: backgroundColor,
              onTap: () => onTap(email),
            ),
          ),
          ...otherContacts.map(
            (contact) => MesChipStatus(
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
