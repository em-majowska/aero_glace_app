import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void emptyCartDialog(BuildContext context) {
  final cart = context.read<CartController>();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsPadding: const EdgeInsets.all(16),
        title: Text(
          context.tr('btn_vider_panier'),
          style: context.textTheme.titleLarge,
        ),
        content: Text(
          context.tr('vider_confirmation_message'),
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
          FilledButton(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: context.colorSchema.error,
            ),
            onPressed: () {
              cart.discardAllItems();
              Navigator.of(context).pop();
            },
            child: Text(
              context.tr('btn_vider_panier'),
              style: TextStyle(color: context.colorSchema.onError),
            ),
          ),
        ],
      );
    },
  );
}
