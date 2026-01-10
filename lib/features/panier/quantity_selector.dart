import 'package:aero_glace_app/providers/cart_controller.dart';
import 'package:aero_glace_app/models/flavor_model.dart';
import 'package:aero_glace_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

/// Widget affichant les boutons `+` / `-` pour modifier la quantité
/// d'un parfum dans le panier.
///
/// Argument :
/// - [flavor] : le parfum associé dont la quantité va être modifiée.
class QuantitySelector extends StatelessWidget {
  /// Modèle de parfum associé.
  final Flavor flavor;

  /// Crée le widget [QuantitySelector] pour le parfum donné [flavor].
  const QuantitySelector({super.key, required this.flavor});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cart, child) {
        return Row(
          spacing: 8,
          children: [
            // Bouton pour diminuer la quantité
            IconButton(
              onPressed: () => cart.removeItem(flavor),
              icon: Icon(
                LucideIcons.minus,
                color: context.colorSchema.onSurface,
              ),
              style: IconButton.styleFrom(
                backgroundColor: context.colorSchema.surfaceDim,
                shape: const CircleBorder(),
              ),
            ),

            // Affiche la quantité actuelle depuis le CartController
            Consumer<CartController>(
              builder: (context, cart, child) {
                final quantity = cart.getItemQuantity(
                  flavor.id,
                );
                return Text(
                  quantity.toString(),
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),

            // Bouton pour augmenter la quantité
            IconButton(
              onPressed: () => cart.addItem(flavor),
              icon: Icon(
                LucideIcons.plus,
                color: context.colorSchema.onPrimaryContainer,
              ),
              style: IconButton.styleFrom(
                backgroundColor: context.colorSchema.inversePrimary,
                shape: const CircleBorder(),
              ),
            ),
          ],
        );
      },
    );
  }
}
