import 'package:aero_glace_app/features/flavors/tag.dart';
import 'package:aero_glace_app/models/flavor_model.dart';
import 'package:aero_glace_app/utils/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Widget affichant les détails du parfum [flavor].
///
/// Argument :
/// - [flavor] : le modèle de données du parfum à afficher.
class FlavorDetails extends StatelessWidget {
  /// Modèle de parfum à afficher.
  final Flavor flavor;

  /// Crée le widget [FlavorDetails].
  const FlavorDetails({super.key, required this.flavor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: flavor.tags
                    .map((key) => Tag(tag: context.tr('tag.$key')))
                    .toList(),
              ),
            ],
          ),

          Text(
            '${flavor.price.toStringAsFixed(2)} €',
            style: context.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
