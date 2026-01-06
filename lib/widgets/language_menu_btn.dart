import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

Widget openLanguageMenu(BuildContext context) {
  return SimpleDialog(
    title: Text(context.tr('langue')),
    titleTextStyle: Theme.of(context).textTheme.titleLarge,
    alignment: Alignment.topRight,
    constraints: const BoxConstraints(maxWidth: 200),
    contentPadding: const EdgeInsetsGeometry.all(16),
    children: [
      SimpleDialogOption(
        onPressed: () {
          context.setLocale(const Locale('fr'));
          Navigator.of(context).pop();
        },
        child: const Row(
          children: [
            Text('FR'),
            SizedBox(width: 16),
            Text('Français'),
          ],
        ),
      ),
      const Divider(),
      SimpleDialogOption(
        onPressed: () {
          context.setLocale(const Locale('ja'));
          Navigator.of(context).pop();
        },
        child: Row(
          children: [
            const Text('JP'),
            const SizedBox(width: 16),
            Text(context.tr('japonais')),
          ],
        ),
      ),
    ],
  );
}

class LanguageMenuButton extends StatelessWidget {
  const LanguageMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) {
          return openLanguageMenu(context);
        },
      ),
      icon: const Icon(LucideIcons.settings200, size: 35),
    );
  }
}
