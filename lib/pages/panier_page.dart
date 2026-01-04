import 'package:aero_glace_app/model/cart_model.dart';
import 'package:aero_glace_app/features/panier/item_tile.dart';
import 'package:aero_glace_app/features/panier/empty_cart_tile.dart';
import 'package:aero_glace_app/features/panier/total_tile.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

class PanierPage extends StatelessWidget {
  const PanierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "votre-commande")),
      ),
      body: Stack(
        children: [
          const MyBackground(assetPath: 'background.jpg'),
          Positioned(
            bottom: -200,
            right: -80,
            child: Image.asset(
              'assets/images/hovering-elements.png',
            ),
          ),
          Consumer<Cart>(
            builder: (context, cart, child) {
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
