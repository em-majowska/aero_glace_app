import 'package:aero_glace_app/model/cart_model.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

final blob = BlobClipper(
  edgesCount: 8,
  minGrowth: 7,
);

class ItemTile extends StatelessWidget {
  final Flavor flavor;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDiscard;

  const ItemTile({
    super.key,
    required this.flavor,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onDiscard,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onDiscard(),
            icon: LucideIcons.trash2,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 3, top: 8, right: 8, bottom: 0),
        child: IntrinsicHeight(
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // image
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

              // title + price
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
                    Consumer<Cart>(
                      builder: (context, cart, child) => Text(
                        '${cart.getItemPrice(flavor).toStringAsFixed(2)} €',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),

              // Add or remove item buttons
              Row(
                spacing: 12,
                children: [
                  IconButton(
                    onPressed: onRemove,
                    icon: Icon(
                      LucideIcons.minus,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.surfaceDim,
                      shape: const CircleBorder(),
                    ),
                  ),
                  Consumer<Cart>(
                    builder: (context, cart, child) {
                      final quantity = cart.getItemQuantity(
                        flavor.id,
                      );
                      return Text(
                        quantity.toString(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: onAdd,
                    icon: Icon(
                      LucideIcons.plus,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.inversePrimary,
                      shape: const CircleBorder(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
