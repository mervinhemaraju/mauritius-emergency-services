import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/core/models/app/locale.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

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
