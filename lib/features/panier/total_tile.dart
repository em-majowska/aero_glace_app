import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';

class TotalTile extends StatelessWidget {
  final double totalPrice;

  const TotalTile({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    // TODO maybe without glossy box?
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  totalPrice.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
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
