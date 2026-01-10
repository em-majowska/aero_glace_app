import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:aero_glace_app/widgets/btn_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

/// Affiche une boîte de dialogue demandant confirmation avant
/// la suppression de tous les articles du panier.
///
/// Utilise le [CartController] pour vider le panier.
/// [context] est requis pour afficher la boîte de dialogue et
/// accéder aux traductions.
void emptyCartDialog(BuildContext context) {
  // Permet d'accéder à méthode pour vider les items du panier.
  final cart = context.read<CartController>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsPadding: const EdgeInsets.all(16),
        title: Text(
          context.tr('btn_empty_cart'),
          style: context.textTheme.titleLarge,
        ),
        content: Text(context.tr('vider_confirmation_message')),

        // Boutons d'action
        actions: [
          // Bouton Annuler
          OutlinedButton(
            style: btnStyle(ButtonType.outlined),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr('btn_cancel')),
          ),

          // Bouton Vider le panier
          FilledButton(
            style: btnStyle(
              ButtonType.filled,
              backgroundColor: context.colorSchema.error,
            ),
            onPressed: () {
              cart.discardAllItems();
              Navigator.of(context).pop();
            },
            child: Text(
              context.tr('btn_empty_cart'),
              style: TextStyle(color: context.colorSchema.onError),
            ),
          ),
        ],
      );
    },
  );
}

/// Affiche une boîte de dialogue indiquant que l'utilisateur
/// doit être connecté pour continuer.
///
/// [context] est requis pour afficher la boîte de dialogue et
/// accéder aux traductions.
void loginDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsPadding: const EdgeInsets.all(16),
        title: Text(
          context.tr('login_required_title'),
          style: context.textTheme.titleLarge,
        ),
        content: Text(
          context.tr('login_required_message'),
        ),
        actions: [
          OutlinedButton(
            style: btnStyle(ButtonType.outlined),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr('btn_cancel')),
          ),
        ],
      );
    },
  );
}

/// Affiche une boîte de dialogue informant l'utilisateur que
/// l'autorisation de localisation est refusée.
///
/// Utilise [permission_handler] pour ouvrir les paramètres système.
/// [context] est requis pour afficher la boîte de dialogue et
/// accéder aux traductions.
void grantLocationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.tr('localization_refused')),
      content: Text(context.tr('localization_permissions_error')),
      actions: [
        OutlinedButton(
          style: btnStyle(ButtonType.outlined),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.tr('btn_cancel')),
        ),
        FilledButton(
          style: btnStyle(ButtonType.filled),
          onPressed: () {
            openAppSettings();
            Navigator.of(context).pop();
          },
          child: Text(context.tr('btn_settings')),
        ),
      ],
    ),
  );
}
