import 'package:aero_glace_app/util/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr('btn_cancel')),
          ),
        ],
      );
    },
  );
}
