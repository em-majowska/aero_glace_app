import 'package:aero_glace_app/features/flavors/tag.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Widget affichant les détails du parfum [flavor] (titre, description, prix, tags)
/// et le bouton d'ajout au panier [onAddToCart].
class FlavorDetails extends StatelessWidget {
  final Flavor flavor;
  final void Function(Flavor) onAddToCart;

  const FlavorDetails({
    super.key,
    required this.flavor,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text(
                flavor.title.tr(),
                style: context.textTheme.titleMedium,
              ),
              Text(
                flavor.description.tr(),
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
          Text(
            '${flavor.price.toStringAsFixed(2)} €',
            style: context.textTheme.titleLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: flavor.tags
                      .map((key) => Tag(tag: context.tr('tag.$key')))
                      .toList(),
                ),
              ),
              IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerLowest,
                  overlayColor: context.colorSchema.primary,
                  shape: CircleBorder(
                    side: BorderSide(
                      color: context.colorSchema.outlineVariant,
                    ),
                  ),
                ),
                onPressed: () => onAddToCart(flavor),
                icon: Icon(
                  LucideIcons.plus,
                  color: context.colorSchema.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
