import 'package:aero_glace_app/util/scaffold_messenger.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

final theme = ThemeData.light();

/// SnackBar personnalisé permettant d'afficher un message avec
/// un style cohérent et une icône optionnelle.
class MySnackBar extends SnackBar {
  MySnackBar({
    super.key,
    required String message,
    required Color textColor,
    required Color backgroundColor,
    Icon? icon,
  }) : super(
         content: Row(
           children: [
             if (icon != null) ...[icon, const SizedBox(width: 8)],
             Expanded(
               child: Text(message, style: TextStyle(color: textColor)),
             ),
           ],
         ),
         duration: const Duration(seconds: 3),
         backgroundColor: backgroundColor,
         padding: const EdgeInsets.all(12),
         shape: const RoundedRectangleBorder(
           borderRadius: BorderRadius.all(Radius.circular(12)),
         ),
         dismissDirection: DismissDirection.horizontal,
         behavior: SnackBarBehavior.floating,
       );
}

/// Affiche une [SnackBar] globale à l'aide du [ScaffoldMessenger].
///
/// Affiche un message depuis n'importe quel endroit de l'application
/// sans dépendre d'un [BuildContext].
///
/// Arguments :
/// - [message] : le texte du message à afficher.
/// - [icon] : icône optionnelle affichée à gauche du message.
/// - [textColor] : couleur du texte (par défaut `onSurface`).
/// - [backgroundColor] : couleur de fond (par défaut `surfaceContainerLow`).
void showSnack({
  required String message,
  Icon? icon,
  Color? textColor,
  Color? backgroundColor,
}) {
  final messenger = scaffoldMessengerKey.currentState;
  if (messenger == null) return;

  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      MySnackBar(
        message: message,
        icon: icon,
        textColor: textColor ?? theme.colorScheme.onSurface,
        backgroundColor:
            backgroundColor ?? theme.colorScheme.surfaceContainerLow,
      ),
    );
}

/// Affiche un message d'erreur à l'utilisateur sous forme de [SnackBar].
///
/// Cette méthode est un raccourci de [showSnack] avec :
/// - une icône d'alerte,
/// - des couleurs adaptées aux messages d'erreur.
///
/// Argument :
/// - [message] : le texte du message d'erreur à afficher.
void showErrorMessage({required String message}) {
  showSnack(
    message: message,
    icon: Icon(
      LucideIcons.triangleAlert,
      color: theme.colorScheme.error,
    ),
    textColor: theme.colorScheme.onErrorContainer,
    backgroundColor: theme.colorScheme.errorContainer,
  );
}

//  TODO add smooth animation
// /* snackBarAnimationStyle: AnimationStyle */
