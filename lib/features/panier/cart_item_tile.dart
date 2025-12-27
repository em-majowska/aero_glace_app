import 'package:aero_glace_app/features/panier/cart_provider.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatefulWidget {
  Flavor flavor;

  CartItemTile({super.key, required this.flavor});

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  void addOneItem(Flavor flavor) {
    Provider.of<CartProvider>(context, listen: false).addItemToCart(flavor);
  }

  void removeOneItem(Flavor flavor) {
    Provider.of<CartProvider>(
      context,
      listen: false,
    ).removeItemFromCart(flavor);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => Padding(
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
                  clipper: BlobClipper(
                    edgesCount: 10,
                    minGrowth: 7,
                  ),
                  child: Image.asset(
                    'assets/images/flavors/${widget.flavor.imagePath}',
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
                      widget.flavor.title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(height: 1.2),
                    ),
                    Text(
                      '${widget.flavor.price.toStringAsFixed(2)} €',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.error,
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
                    onPressed: () => removeOneItem(widget.flavor),
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
                  Text(
                    '${widget.flavor.qty}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => addOneItem(widget.flavor),
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
