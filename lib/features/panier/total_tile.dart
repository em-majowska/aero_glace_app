import 'package:aero_glace_app/features/panier/alert_dialogs.dart';
import 'package:aero_glace_app/model/cart_controller.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:aero_glace_app/widgets/btn_style.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

/// Widget affichant le total prix des items dans les panier.
///
/// Montre:
/// - le total des produits,
/// - les économies réalisées si une remise est appliquée,
/// - le total après remise,
/// - boutons 'vider le panier' et 'commander'.
class TotalTile extends StatelessWidget {
  /// Crée le widget [TotalTile].
  const TotalTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<CartController>(
          builder: (context, cart, child) {
            final total = cart.getTotalPrice();
            final savings = cart.getSavings(total);
            final totalDiscounted = cart.getTotalPriceDiscounted(total);
            return Column(
              children: [
                // Total des produits et les économies
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
                              color: context.colorSchema.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                const Divider(),

                // Total final
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.tr('total'),
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      (cart.discount > 0)
                          ? '${totalDiscounted.toStringAsFixed(2)} €'
                          : '${total.toStringAsFixed(2)} €',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Boutons d'action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 8,
                  children: [
                    // Bouton pour vider le panier
                    OutlinedButton(
                      onPressed: () => emptyCartDialog(context),
                      style: btnStyle(
                        ButtonType.outlined,
                        side: BorderSide(color: context.colorSchema.error),
                        foregroundColor: context.colorSchema.error,
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          Icon(
                            LucideIcons.trash2,
                            color: context.colorSchema.error,
                          ),
                          Text(
                            context.tr('btn_empty_cart'),
                            style: TextStyle(color: context.colorSchema.error),
                          ),
                        ],
                      ),
                    ),

                    // Bouton pour passer la commande
                    FilledButton(
                      onPressed: () {
                        bool isLoggedIn = false;
                        if (!isLoggedIn) loginDialog(context);
                      },
                      style: btnStyle(
                        ButtonType.filled,
                        backgroundColor: context.colorSchema.primary,
                      ),
                      child: Text(
                        context.tr('btn_order'),
                        style: TextStyle(color: context.colorSchema.onPrimary),
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
