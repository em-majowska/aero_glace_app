import 'package:aero_glace_app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Affiche un message d'erreur à l'utilisateur sous forme de [SnackBar].
///
/// Utilise [ScaffoldMessenger] pour afficher un [MySnackBar] personnalisé
/// avec une icône d'alerte et le texte fourni.
///
/// Arguments :
/// - [context] : contexte du widget utilisé pour accéder au [ScaffoldMessenger].
/// - [message] : le texte du message d'erreur à afficher.
void errorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    MySnackBar(
      context: context,
      icon: const Icon(LucideIcons.triangleAlert),
      message: message,
    ),
  );
}
