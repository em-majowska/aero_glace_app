import 'package:aero_glace_app/util/theme.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Widget affichant un message indiquant que le panier est vide.
///
/// Affiché lorsque la quantité d'items dans le panier est inférieure à 1.
class EmptyCartTile extends StatelessWidget {
  /// Crée le widget EmptyCartTile.
  const EmptyCartTile({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: GlossyBox(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(LucideIcons.handbag200, size: 85),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    context.tr('panier_vide'),
                    style: context.textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
