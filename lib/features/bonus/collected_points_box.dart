import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CollectedPointsBox extends StatelessWidget {
  const CollectedPointsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 24,
          children: [
            Row(
              // top row
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  // points + lvl
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Points de fidelité',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '260',
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
                  ],
                ),
                Row(
                  // lvl + trophy
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 5,
                  children: [
                    Text(
                      'Lvl 2',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('260 points'), Text('500 points')],
                ),
                StepProgressIndicator(
                  totalSteps: 500,
                  currentStep: 260,
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

            // prizes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 16,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(
                        context,
                      ).colorScheme.tertiaryContainer,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '🍨',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '250 pts',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onTertiaryContainer,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '🏖️',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '500 pts',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '🎁',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '1500 pts',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
