import 'dart:async';
import 'package:aero_glace_app/features/bonus/fortune_wheel.dart';
import 'package:aero_glace_app/features/bonus/result.dart';
import 'package:aero_glace_app/model/fortune_wheel_controller.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:aero_glace_app/widgets/btn_style.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Widget affichant la roue de la fortune et la remise / les points gagné.
///
/// L’état et les résultats sont pilotés par le [FortuneWheelController].
/// La roue de la fortune ne peut être utilisée qu'une fois par jour.
/// L'état est mis à jour et la roue est débloquée automatiquement à minuit.
class FortuneWheelTile extends StatefulWidget {
  /// Crée le widget [FortuneWheelTile].
  const FortuneWheelTile({super.key});

  @override
  State<FortuneWheelTile> createState() => _FortuneWheelTileState();
}

class _FortuneWheelTileState extends State<FortuneWheelTile> {
  /// Contrôleur de flux utilisé pour déclencher l’animation
  /// de la roue de la fortune.
  ///
  /// Chaque valeur envoyée correspond à un index de résultat.
  late final StreamController<int> controller = StreamController<int>();

  @override
  void dispose() {
    /// Libère le contrôleur de flux lors de la destruction du widget
    /// poour éviter les fuites de données.
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<FortuneWheelController>(
          builder: (context, fortuneWheel, child) {
            // Indique si la roue peut actuellement être lancée.
            final isActive = fortuneWheel.isWheelActive;

            /// Lance la roue de la fortune si elle est active.
            ///
            /// - Tire un résultat aléatoire via le contrôleur métier
            /// - Envoie l’index au [controller] pour déclencher l’animation
            void spinTheWheel() {
              if (!isActive) return;
              fortuneWheel.getRandomFortuneItem();
              controller.add(fortuneWheel.random);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 24,
              children: [
                Center(
                  child: Text(
                    context.tr('fortune_wheel'),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  // Conteneur circulaire de la roue
                  child: Container(
                    width: 270,
                    height: 270,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: context.colorSchema.primaryContainer,
                      border: Border.all(
                        width: 2,
                        color: context.colorSchema.primaryFixedDim,
                      ),
                      shape: BoxShape.circle,
                    ),

                    /// Roue de la fortune animée
                    child: FortuneWheelElement(
                      controller: controller,
                      onSpin: spinTheWheel,
                    ),
                  ),
                ),

                /// Résultat affiché une fois la roue arrêtée
                if (!isActive)
                  Result(
                    result: fortuneWheel.result.value,
                    isDiscount: fortuneWheel.result.type == 'discount',
                  ),

                /// Bouton de lancement ou message d'attente
                /// si la roue n'est pas active
                Center(
                  child: FilledButton(
                    style: btnStyle(
                      ButtonType.filled,
                      disabledBackgroundColor: Colors.transparent,
                    ),
                    // Bloque la roue si elle a déjà été lancée aujourd'hui
                    onPressed: (isActive) ? spinTheWheel : null,
                    child: (isActive)
                        ? Text(
                            context.tr('spin_wheel'),
                            style: TextStyle(
                              fontSize: 16,
                              color: context.colorSchema.onPrimary,
                            ),
                          )
                        : Text(
                            context.tr('try_tomorrow'),
                            style: TextStyle(
                              fontSize: 16,
                              color: context.colorSchema.secondary,
                            ),
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
