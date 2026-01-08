import 'package:aero_glace_app/features/panier/item_tile.dart';
import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:aero_glace_app/model/item_model.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Widget affichant la liste des items au panier.
///
class CartItemsList extends StatelessWidget {
  final List<Item> items;
  const CartItemsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: Consumer<CartController>(
        builder: (context, cart, child) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 12),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final flavor = item.flavor;

              // Widget représentant un item du panier
              return ItemTile(
                flavor: flavor,
                quantity: item.qty,
              );
            },
          );
        },
      ),
    );
  }
}
