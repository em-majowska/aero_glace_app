import 'package:aero_glace_app/model/cart_model.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class TotalTile extends StatelessWidget {
  final VoidCallback onDiscardAll;

  const TotalTile({
    super.key,
    required this.onDiscardAll,
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
              FlutterI18n.translate(context, "vider-panier"),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Text(
              FlutterI18n.translate(context, "vider-confirmation"),
            ),
            actions: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(FlutterI18n.translate(context, "annuler")),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () {
                  onDiscardAll();
                  Navigator.of(context).pop();
                },
                child: Text(
                  FlutterI18n.translate(context, "vider-panier"),
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
        child: Consumer<Cart>(
          builder: (context, cart, child) {
            return Column(
              children: [
                if (cart.discount > 0)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FlutterI18n.translate(context, "total-produits"),
                          ),
                          Text(
                            '${cart.totalPrice.toStringAsFixed(2)} €',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FlutterI18n.translate(context, "economie-realisee"),
                          ),
                          Text(
                            '- ${cart.savings.toStringAsFixed(2)} €',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      FlutterI18n.translate(context, "total"),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      (cart.discount > 0)
                          ? '${cart.totalPriceDiscounted.toStringAsFixed(2)} €'
                          : '${cart.totalPrice.toStringAsFixed(2)} €',
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
                            FlutterI18n.translate(context, "vider-panier"),
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
                        FlutterI18n.translate(context, "commander"),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
