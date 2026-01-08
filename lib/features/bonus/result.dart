import 'package:aero_glace_app/util/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Widget affichant le résultat d'un lancement de roue de la fortune.
///
/// Affiche soi :
/// une réduction si [isDiscount] est `true`, soit
/// un nombre de points gagnés si [isDiscount] est `false`.
///
/// Arguments :
/// - [result] : valeur du gain (points ou pourcentage de réduction).
/// - [isDiscount] : indique si le résultat représente une réduction.
class Result extends StatelessWidget {
  /// Valeur du gain (poins ou pourcentage de réduction).
  final int result;

  /// Indique si le résultat est une réduction `true` ou des points `false`
  final bool isDiscount;

  /// Crée le widget [Result] pour afficher le résultat de la roue.
  const Result({
    super.key,
    required this.result,
    required this.isDiscount,
  });

  @override
  Widget build(BuildContext context) {
    final String value = (isDiscount)
        ? context.tr(
            'reduction',
            namedArgs: {'result': result.toString()},
          )
        : context.tr('result_points', namedArgs: {'result': result.toString()});

    return Center(
      child: Column(
        spacing: 8,
        children: [
          Text(context.tr('vous_avez_gagne')),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorSchema.onPrimaryFixedVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
