import 'package:aero_glace_app/features/bonus/gift.dart';
import 'package:aero_glace_app/providers/fortune_wheel_controller.dart';
import 'package:aero_glace_app/utils/context_extensions.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

/// Widget affichant le nombre de points bonus collectés par l’utilisateur.
///
/// Montre :
/// - le total de points de fidélité collectés,
/// - le niveau actuel,
/// - une barre de progression vers le niveau suivant,
/// - les récompenses déblocables.
class CollectedPoints extends StatefulWidget {
  /// Crée le widget [CollectedPoints] pour afficher le nombre de points bonus collectés par l’utilisateur.
  const CollectedPoints({super.key});

  @override
  State<CollectedPoints> createState() => _CollectedPointsState();
}

class _CollectedPointsState extends State<CollectedPoints> {
  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<FortuneWheelController>(
          builder: (context, fortuneWheel, child) {
            return Column(
              spacing: 24,
              children: [
                Row(
                  // Total de points et le niveau actuel
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 16,
                  children: [
                    // Icône + total des points de fidélité
                    Expanded(
                      child: Row(
                        spacing: 8,
                        children: [
                          // Icône décorative représentant les points
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.colorSchema.tertiaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.auto_awesome,
                              color: context.colorSchema.onTertiaryFixed,
                            ),
                          ),

                          // Label et la valeur des points
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr('points_fidelite'),
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(height: 1.2),
                                ),
                                Animate(
                                  key: ValueKey<int>(fortuneWheel.points),
                                  effects: [
                                    const ScaleEffect(
                                      begin: Offset(0.9, 0.9),
                                      end: Offset(1, 1),
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    ),
                                  ],
                                  child: Text(
                                    fortuneWheel.points.toString(),
                                    style: context.textTheme.titleLarge
                                        ?.copyWith(
                                          color: context.colorSchema.error,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Niveau actuel + icône trophée
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: 5,
                      children: [
                        Text(
                          'Lvl ${fortuneWheel.level.value}',
                          style: context.textTheme.titleLarge?.copyWith(
                            color: context.colorSchema.error,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        Icon(
                          LucideIcons.trophy200,
                          size: 40,
                          color: Theme.of(
                            context,
                          ).colorScheme.error,
                        ),
                      ],
                    ),
                  ],
                ),

                Column(
                  spacing: 8,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.tr(
                            'bar_points_collected',
                            namedArgs: {
                              'points': fortuneWheel.points.toString(),
                            },
                          ),
                        ),
                        Text(
                          context.tr(
                            'bar_points_max',
                            namedArgs: {
                              'maxPoints': fortuneWheel.level.maxPoints
                                  .toString(),
                            },
                          ),
                        ),
                      ],
                    ),

                    /// Barre de progression des points.
                    ///
                    /// - [currentStep] (`fortuneWheel.points`) : points actuellement collectés.
                    /// - [totalSteps] (`fortuneWheel.level.maxPoints`) :
                    /// points requis pour atteindre le prochain nivea et
                    /// débloquer des récompenses.
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: StepProgressIndicator(
                        currentStep:
                            (fortuneWheel.points > fortuneWheel.level.maxPoints)
                            ? fortuneWheel.level.maxPoints
                            : fortuneWheel.points,
                        totalSteps: fortuneWheel.level.maxPoints,
                        size: 20,
                        padding: 0,
                        selectedColor: context.colorSchema.tertiary,
                        unselectedColor: context.colorSchema.tertiaryContainer,
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue.shade200,
                            Colors.purple.shade200,
                          ],
                        ),
                        unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            context.colorSchema.surfaceContainerLowest,
                            context.colorSchema.surfaceContainerLow,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Récompenses déblocables selon le nombre de points
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: 16,
                    children: AnimateList(
                      delay: 500.ms,
                      interval: 400.ms,
                      effects: [const ShimmerEffect()],
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Gift(emoji: '🍨', minPoints: 250),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Gift(emoji: '🏖️', minPoints: 500),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Gift(emoji: '🎁', minPoints: 1500),
                        ),
                      ],
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
