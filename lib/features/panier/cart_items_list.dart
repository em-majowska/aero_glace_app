import 'package:aero_glace_app/features/panier/item_tile.dart';
import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:aero_glace_app/model/item_model.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Widget affichant la liste des items au panier.
///
/// Argument :
/// - [items] : liste des objets [Item] à afficher dans le panier, sauvegardés dans le [HiveBox].
class CartItemsList extends StatelessWidget {
  /// Liste des items du panier provenant du HiveBox.
  final List<Item> items;

  /// Crée le widget [CartItemsList] avec la liste d’items fournie.
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
