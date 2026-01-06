import 'package:aero_glace_app/data/default_flavors.dart';
import 'package:aero_glace_app/model/cart_model.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
              context.tr('btn_vider_panier'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Text(
              context.tr('vider_confirmation_message'),
            ),
            actions: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.tr('btn_cancel')),
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
                  context.tr('btn_vider_panier'),
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

    // show dialog to log in
    void showLoginRequiredDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: const EdgeInsets.all(16),
            title: Text(
              context.tr('login_required_title'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Text(
              context.tr('login_required_message'),
            ),
            actions: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.tr('btn_cancel')),
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
            final flavors = getDefaultFlavors(context);
            final total = cart.getTotalPrice(flavors);
            final savings = cart.getSavings(total);
            final totalDiscounted = cart.getTotalPriceDiscounted(total);
            return Column(
              children: [
                if (cart.discount > 0)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.tr('total_produits')),
                          Text('${total.toStringAsFixed(2)} €'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(context.tr('economie_realisee')),
                          Text(
                            '- ${savings.toStringAsFixed(2)} €',
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
                      context.tr('total'),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      (cart.discount > 0)
                          ? '${totalDiscounted.toStringAsFixed(2)} €'
                          : '${total.toStringAsFixed(2)} €',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: emptyCart,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
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
                            context.tr('btn_vider_panier'),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        bool isLoggedIn = false;
                        if (!isLoggedIn) showLoginRequiredDialog();
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary,
                      ),
                      child: Text(
                        context.tr('btn_commander'),
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
