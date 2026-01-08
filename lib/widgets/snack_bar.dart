import 'package:flutter/material.dart';

/// SnackBar personnalisé pour afficher un message avec une icône.
///
/// Ce widget étend [SnackBar] et permet d'afficher :
/// - une icône à gauche,
/// - un message texte étendu,
/// - un style flottant avec coins arrondis et padding personnalisé.
///
/// Arguments :
/// - [context] : le [BuildContext] utilisé pour récupérer le thème et les couleurs.
/// - [icon] : le widget icône à afficher à gauche du message.
/// - [message] : le texte du message à afficher.
class MySnackBar extends SnackBar {
  MySnackBar({
    super.key,
    required BuildContext context,
    required Widget icon,
    required String message,
  }) : super(
         content: Row(
           children: [
             icon,
             const SizedBox(width: 8),
             Expanded(
               child: Text(
                 message,
                 style: TextStyle(
                   color: Theme.of(context).colorScheme.onSurface,
                 ),
               ),
             ),
           ],
         ),
         duration: const Duration(seconds: 3),
         backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
         padding: const EdgeInsets.all(12),
         shape: const RoundedRectangleBorder(
           borderRadius: BorderRadius.all(Radius.circular(12)),
         ),
         dismissDirection: DismissDirection.horizontal,
         behavior: SnackBarBehavior.floating,
       );
}
