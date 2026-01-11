import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Ouvre un menu de sélection de la langue.
///
/// Permet à l'utilisateur de choisir entre le français et le japonais.
/// Change la locale de l'application via [EasyLocalization].
///
/// Arguments :
/// - [context] : contexte de l'application utilisé pour accéder à
///   la localisation et naviguer.
Widget openLanguageMenu(BuildContext context) {
  return Animate(
    child: SimpleDialog(
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
    ),
  ).animate().fadeIn();
}

/// Bouton affichant une icône pour ouvrir le menu de langue.
///
/// Appuie sur le bouton pour lancer [openLanguageMenu] dans un [Dialog].
class LanguageMenuButton extends StatelessWidget {
  const LanguageMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) => openLanguageMenu(context),
      ),
      icon: const Icon(LucideIcons.settings200, size: 35),
    );
  }
}
