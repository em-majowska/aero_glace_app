import 'package:aero_glace_app/util/scaffold_messenger.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

final theme = ThemeData.light();

/// SnackBar personnalisé pour afficher un message avec une icône.
///
/// Ce widget étend [SnackBar] et permet d'afficher :
/// - une icône à gauche,
/// - un message texte étendu,
/// - un style flottant avec coins arrondis et padding personnalisé.
///
/// Arguments :
/// - [message] : le texte du message à afficher.
/// - [icon] : le widget icône à afficher à gauche du message, optionnel. // TODO change doc blocks
class MySnackBar extends SnackBar {
  MySnackBar({
    super.key,
    required String message,
    Icon? icon,
    required Color textColor,
    required Color backgroundColor,
  }) : super(
         content: Row(
           children: [
             if (icon != null) ...[
               icon,
               const SizedBox(width: 8),
             ],
             Expanded(
               child: Text(
                 message,
                 style: TextStyle(color: textColor),
               ),
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
/// Utilise [ScaffoldMessenger] pour afficher un [MySnackBar] personnalisé
/// avec une icône d'alerte et le texte fourni.
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
