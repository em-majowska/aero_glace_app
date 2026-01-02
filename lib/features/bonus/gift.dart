import 'package:aero_glace_app/model/fortune_wheel_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Gift extends StatelessWidget {
  final String emoji;
  final int minPoints;

  const Gift({super.key, required this.emoji, required this.minPoints});

  @override
  Widget build(BuildContext context) {
    return Consumer<FortuneWheelModel>(
      builder: (context, fortuneWheel, child) {
        return Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: (fortuneWheel.points > minPoints)
                  ? Theme.of(context).colorScheme.tertiaryContainer
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: Column(
              children: [
                Text(
                  emoji,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$minPoints pts',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: (fortuneWheel.points > minPoints)
                        ? Theme.of(context).colorScheme.onTertiaryContainer
                        : Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
