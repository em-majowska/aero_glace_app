import 'package:aero_glace_app/features/panier/quantity_selector.dart';
import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

final blob = BlobClipper(
  edgesCount: 8,
  minGrowth: 7,
);

/// Widget affichant un item du panier avec des infos essentiels.
///
/// Permet de :
/// - Afficher l'image, le titre et le prix d'un parfum.
/// - Modifier la quantité avec les boutons + / -.
/// - Supprimer l'item via un glissement [Slidable].
class ItemTile extends StatelessWidget {
  final Flavor flavor;
  final int quantity;

  const ItemTile({
    super.key,
    required this.flavor,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    // Glissement pour supprimer l’item
    return Consumer<CartController>(
      builder: (context, cart, child) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => cart.discardItem(flavor),
                icon: LucideIcons.trash2,
                backgroundColor: context.colorSchema.tertiary,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 3,
              top: 8,
              right: 8,
              bottom: 0,
            ),
            child: IntrinsicHeight(
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Image du parfum avec clipper décoratif
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipPath(
                      clipper: blob,
                      child: Image.asset(
                        'assets/images/flavors/${flavor.imagePath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Titre, prix et sélection de quantité
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          flavor.title,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(height: 1.2),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Consumer<CartController>(
                              builder: (context, cart, child) => Text(
                                '${cart.getItemPrice(flavor).toStringAsFixed(2)} €',
                                style: context.textTheme.titleMedium,
                              ),
                            ),

                            // Boutons + / - pour modifier la quantité
                            QuantitySelector(flavor: flavor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
