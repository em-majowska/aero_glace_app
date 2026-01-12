import 'dart:ui';
import 'package:aero_glace_app/utils/context_extensions.dart';
import 'package:aero_glace_app/widgets/language_menu_btn.dart';
import 'package:flutter/material.dart';

/// Classe utilitaire pour créer un [AppBar] personnalisé.
class MyAppBar {
  PreferredSizeWidget? appBar(BuildContext context, title) {
    return AppBar(
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),

      // Couleur de fond légèrement transparente
      backgroundColor: context.colorSchema.surface.withValues(alpha: 0.1),

      // Supprime l'ombre lorsque l'app bar est scrollée
      scrolledUnderElevation: 0,

      // Effet "glossy" derrière l'app bar
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            color: context.colorSchema.surface.withValues(alpha: 0.7),
          ),
        ),
      ),
      actions: [const LanguageMenuButton()],
    );
  }
}
