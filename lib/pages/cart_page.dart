import 'package:aero_glace_app/data/flavors_list.dart';
import 'package:aero_glace_app/features/panier/cart_items_list.dart';
import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:aero_glace_app/features/panier/item_tile.dart';
import 'package:aero_glace_app/features/panier/empty_cart_tile.dart';
import 'package:aero_glace_app/features/panier/total_tile.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:aero_glace_app/widgets/language_menu_btn.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Page affichant le contenu du panier
///
/// Montre la liste des parfums ajoutés, permet d'ajouter, supprimer ou vider
/// des items, et affiche le total.
class CartPage extends StatefulWidget {
  /// Crée la page du panier.
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final flavors = getFlavors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('votre_commande')),
        actions: [const LanguageMenuButton()],
        backgroundColor: context.colorSchema.surface,
        scrolledUnderElevation: 0.0,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const MyBackground(assetPath: 'background4.jpg'),

          // Éléments flottants décoratifs
          Positioned(
            bottom: -200,
            right: -80,
            child: Image.asset(
              'assets/images/hovering-elements.png',
            ),
          ),

          // Contenu principal du panier
          Consumer<CartController>(
            builder: (context, cart, child) {
              // Met à jour les items du panier
              cart.getItems(flavors);

              if (cart.items.isEmpty) {
                // Affiche un widget indiquant que le panier est vide
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: EmptyCartTile(),
                );
              } else {
                // Affiche la liste des items et le total
                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    const GlossyBox(child: CartItemsList()),
                    const SizedBox(height: 24),

                    // Widget affichant le total et bouton de suppression de tous les items
                    TotalTile(onDiscardAll: cart.discardAllItems),
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
