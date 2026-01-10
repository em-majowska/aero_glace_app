import 'dart:async';
import 'package:aero_glace_app/providers/cart_controller.dart';
import 'package:aero_glace_app/providers/fortune_wheel_controller.dart';
import 'package:aero_glace_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

/// Widget affichant la roue de la fortune.
///
/// La roue peut générer un résultat aléatoire lorsqu'elle est lancée.
/// Les résultats peuvent être :
/// - une réduction (`discount`) appliquée au panier, ou
/// - des points fidélité ajoutés au compte d'utilisateur.
///
/// Arguments :
/// - [controller] : [StreamController<int>] utilisé pour indiquer
///   la sélection actuelle de la roue et déclencher la mise à jour du résultat.
/// - [onSpin] : Callback déclenché lorsque l'utilisateur fait tourner la roue.
class FortuneWheelElement extends StatelessWidget {
  /// Contrôleur pour gérer le flux de l'item sélectionné.
  final StreamController<int> controller;

  /// Callback déclenché lors du lancement de la roue.
  final VoidCallback onSpin;

  /// Crée un widget [FortuneWheelElement].
  const FortuneWheelElement({
    super.key,
    required this.controller,
    required this.onSpin,
  });

  // Couleurs alternées pour les segments de la roue
  static final segmentColors = [
    Colors.blue.shade100,
    Colors.red.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: Consumer<FortuneWheelController>(
            builder: (context, fortuneWheel, child) {
              return FortuneWheel(
                physics: CircularPanPhysics(
                  duration: const Duration(seconds: 1),
                  curve: Curves.decelerate,
                ),
                hapticImpact: HapticImpact.light,
                selected: controller.stream,
                onFling: onSpin,

                /// Cette logique est exécutée à la fin de l'animation de la roue.
                ///
                /// - La roue est désactivée jusqu'au lendemain.
                /// - Si le résultat est un `discount`, la date d'expiration est mise à jour dans le [CartController].
                /// - Sinon, les points sont ajoutés à l'utilisateur.
                /// - Le résultat obtenu est affiché à l'utilisateur.
                onAnimationEnd: () {
                  if (!fortuneWheel.isWheelActive) return;

                  final cart = context.read<CartController>();
                  final now = DateTime.now();

                  fortuneWheel.disableWheel(now);
                  if (fortuneWheel.result.type == 'discount') {
                    cart.setDiscount(fortuneWheel.result.value, now);
                  } else {
                    cart.setDiscount(0, now);
                    fortuneWheel.addPoints(fortuneWheel.result.value);
                  }
                },
                animateFirst: false,
                indicators: <FortuneIndicator>[
                  FortuneIndicator(
                    alignment: Alignment.topCenter,
                    child: TriangleIndicator(
                      color: context.colorSchema.primary,
                      width: 25,
                      height: 25,
                      elevation: 3,
                    ),
                  ),
                ],

                // Segments de la roue
                items: List.generate(fortuneWheel.fortuneItems.length, (i) {
                  return FortuneItem(
                    style: FortuneItemStyle(
                      borderWidth: 2,
                      borderColor: Colors.white,
                      color: (i % 2 == 0) ? segmentColors[0] : segmentColors[1],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          // Positionne le texte représentant la valeur du segment sur la roue
                          right: 20,
                          child: RotatedBox(
                            quarterTurns: 5,
                            child: Text(
                              fortuneWheel.displayValue(
                                fortuneWheel.fortuneItems[i],
                              ),
                              style: context.textTheme.labelLarge?.copyWith(
                                color: context.colorSchema.onPrimaryContainer,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              );
            },
          ),
        ),

        // Icône centrale
        Center(
          child: Container(
            width: 45,
            height: 45,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colorSchema.surface,
            ),
            child: Icon(
              LucideIcons.iceCreamCone300,
              size: 30,
              color: context.colorSchema.primary,
            ),
          ),
        ),
      ],
    );
  }
}
