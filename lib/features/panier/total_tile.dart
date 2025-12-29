import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TotalTile extends StatelessWidget {
  final double totalPrice;
  final VoidCallback empty;

  const TotalTile({
    super.key,
    required this.totalPrice,
    required this.empty,
  });

  @override
  Widget build(BuildContext context) {
    // show dialog to confirm the action
    void emptyCart() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: const EdgeInsets.all(16),
            title: Text(
              'Vider le panier',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: const Text(
              'Êtes-vous sûr de vouloir vider votre panier ? Cette action est irréversible et tous les articles seront supprimés.',
            ),
            actions: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Annuler'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () {
                  empty();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Vider le panier',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

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
                  '${totalPrice.toStringAsFixed(2)} €',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: emptyCart,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                  child: Row(
                    spacing: 8,
                    children: [
                      Icon(
                        LucideIcons.trash2,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      Text(
                        'Vider',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ),
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
          ],
        ),
      ),
    );
  }
}
