import 'package:aero_glace_app/features/bonus/gift.dart';
import 'package:aero_glace_app/model/fortune_wheel_model.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CollectedPointsBox extends StatefulWidget {
  const CollectedPointsBox({super.key});

  @override
  State<CollectedPointsBox> createState() => _CollectedPointsBoxState();
}

class _CollectedPointsBoxState extends State<CollectedPointsBox> {
  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<FortuneWheelModel>(
          builder: (context, fortuneWheel, child) {
            return Column(
              spacing: 24,
              children: [
                Row(
                  // top row
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 16,
                  children: [
                    // points + lvl
                    Expanded(
                      child: Row(
                        spacing: 8,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.tertiaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.auto_awesome,
                              color: Theme.of(
                                context,
                              ).colorScheme.onTertiaryFixed,
                            ),
                          ),

                          // points
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr('points_fidelite'),
                                  style:
                                      Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.copyWith(
                                        height: 1.2,
                                      ),
                                ),
                                Text(
                                  fortuneWheel.points.toString(),
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      // lvl + trophy
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: 5,
                      children: [
                        Text(
                          'Lvl ${fortuneWheel.level.value}',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.error,
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

                // points bar
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

                    StepProgressIndicator(
                      totalSteps: fortuneWheel.level.maxPoints,
                      currentStep: fortuneWheel.points,
                      size: 20,
                      padding: 0,
                      selectedColor: Theme.of(context).colorScheme.tertiary,
                      unselectedColor: Theme.of(
                        context,
                      ).colorScheme.tertiaryContainer,
                      roundedEdges: const Radius.circular(10),
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
                          Theme.of(context).colorScheme.surfaceContainerLowest,
                          Theme.of(context).colorScheme.surfaceContainerLow,
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: 8,
                  children: [
                    Text(
                      context.tr('gagnez'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 16,
                        children: [
                          Gift(emoji: '🍨', minPoints: 250),
                          Gift(emoji: '🏖️', minPoints: 500),
                          Gift(emoji: '🎁', minPoints: 1500),
                        ],
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
