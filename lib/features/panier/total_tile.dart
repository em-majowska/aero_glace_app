import 'package:aero_glace_app/features/panier/cart_provider.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalTile extends StatefulWidget {
  const TotalTile({super.key});

  @override
  State<TotalTile> createState() => _TotalTileState();
}

class _TotalTileState extends State<TotalTile> {
  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style:
                      Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Consumer<CartProvider>(
                  builder: (context, value, child) => Text(
                    ' ${value.getTotalValue().toStringAsFixed(2)}€',
                    style:
                        Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary,
              ),
              child: Text(
                'Commander',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
