import 'package:aero_glace_app/data/flavors_list.dart';
import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:aero_glace_app/features/panier/item_tile.dart';
import 'package:aero_glace_app/features/panier/empty_cart_tile.dart';
import 'package:aero_glace_app/features/panier/total_tile.dart';
import 'package:aero_glace_app/widgets/language_menu_btn.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flavors = getFlavors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('votre_commande')),
        actions: [const LanguageMenuButton()],
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0.0,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const MyBackground(assetPath: 'background4.jpg'),
          Positioned(
            bottom: -200,
            right: -80,
            child: Image.asset(
              'assets/images/hovering-elements.png',
            ),
          ),
          Consumer<CartController>(
            builder: (context, cart, child) {
              cart.getItems(flavors);
              if (cart.items.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: EmptyCartTile(),
                );
              } else {
                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    GlossyBox(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 12),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          final flavor = item.flavor;

                          return ItemTile(
                            flavor: flavor,
                            quantity: item.qty,
                            onAdd: () => cart.addItem(flavor),
                            onRemove: () => cart.removeItem(flavor),
                            onDiscard: () => cart.discardItem(flavor),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    TotalTile(
                      onDiscardAll: cart.discardAllItems,
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
