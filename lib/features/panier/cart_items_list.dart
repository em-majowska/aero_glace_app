import 'package:aero_glace_app/features/panier/item_tile.dart';
import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Widget affichant la liste des items au panier.
class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cart, child) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 12),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            final item = cart.items[index];
            final flavor = item.flavor;

            // Widget représentant un item du panier
            return ItemTile(
              flavor: flavor,
              quantity: item.qty,
            );
          },
        );
      },
    );
  }
}
