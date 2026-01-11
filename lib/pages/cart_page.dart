import 'package:aero_glace_app/features/panier/cart_items_list.dart';
import 'package:aero_glace_app/providers/cart_controller.dart';
import 'package:aero_glace_app/features/panier/empty_cart_tile.dart';
import 'package:aero_glace_app/features/panier/total_tile.dart';
import 'package:aero_glace_app/utils/animations.dart';
import 'package:aero_glace_app/utils/theme.dart';
import 'package:aero_glace_app/widgets/language_menu_btn.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

/// Page affichant le contenu du panier
///
/// Retourne un [Scaffold] contenant une [AppBar] incluant
/// un sélecteur de langue et une liste de parfums ajoutés au panier.
/// Permet d'ajouter, supprimer ou vider des items, et
/// affiche le total avec la remise (si existe).
class CartPage extends StatefulWidget {
  /// Crée la page du panier.
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('votre_commande'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
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
            child:
                Image.asset(
                      'assets/images/hovering-elements.png',
                    )
                    .animate(
                      delay: 200.ms,
                      onPlay: (controller) => controller.forward(),
                    )
                    .slide(
                      begin: const Offset(-0.2, 0.8),
                      end: const Offset(0, 0.15),
                      duration: 5.seconds,
                      curve: Curves.easeInOutBack,
                    )
                    .rotate(
                      begin: -0.08,
                      end: 0,
                      duration: 5.seconds,
                      curve: Curves.easeInOutBack,
                    ),
          ),

          // Contenu principal du panier
          Consumer<CartController>(
            builder: (context, cart, child) {
              // Met à jour les items du panier
              final items = cart.getItems();

              if (items.isEmpty) {
                // Affiche un widget indiquant que le panier est vide
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const EmptyCartTile().animate(delay: 200.ms).fadeIn(),
                );
              } else {
                // Liste des items et le total
                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    CartItemsList(
                      items: items,
                    ).animate(delay: 200.ms, effects: slideIn),
                    const SizedBox(height: 24),

                    // Total et bouton de suppression de tous les items
                    const TotalTile().animate(delay: 400.ms, effects: slideIn),
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
