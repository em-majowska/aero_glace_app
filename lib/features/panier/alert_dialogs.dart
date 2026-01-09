import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:aero_glace_app/widgets/btn_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

/// Affiche une boîte de dialogue pour confirmer la suppression de tous les
/// [Item] du panier.
///
/// Utilise le [CartController] pour vider le panier.
/// [context] est requis pour afficher la boîte de dialogue et
/// accéder aux traductions
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
        content: Text(
          context.tr('vider_confirmation_message'),
        ),

        // Boutons d'action
        actions: [
          // Bouton Annuler
          OutlinedButton(
            style: btnStyle('outlined'),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr('btn_cancel')),
          ),

          // Bouton Vider le panier
          FilledButton(
            style: btnStyle(
              'filled',
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

/// Affiche une boîte de dialogue indiquant que l'utilisateur doit se connecter.
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
            style: btnStyle('outlined'),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr('btn_cancel')),
          ),
        ],
      );
    },
  );
}

void grantLocationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Localisation refusée'), // TODO translate
      content: const Text(
        'Autorisation de localisation refusée. Activez-la dans les paramètres.', // TODO translate
      ),
      actions: [
        OutlinedButton(
          style: btnStyle('outlined'),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.tr('btn_cancel')),
        ),
        FilledButton(
          style: btnStyle('filled'),
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
