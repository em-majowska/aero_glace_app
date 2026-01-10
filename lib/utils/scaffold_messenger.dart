import 'package:flutter/material.dart';

/// Clé globale utilisée pour accéder au [ScaffoldMessengerState].
///
/// Permet d'afficher des [SnackBar] depuis n'importe où dans l'application
/// (par exemple depuis un service, un contrôleur ou un callback hors du
/// contexte du widget).
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
