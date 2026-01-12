import 'package:aero_glace_app/providers/fortune_wheel_controller.dart';
import 'package:aero_glace_app/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

/// Widget affichant une récompense déblocable
///
/// La récompense devient visuellment active lorsque l'utilisateur atteint
/// le nombre de points requis [minPoints].
///
/// Argument :
/// [emoji] : Emoji représentant la récompense.
class Gift extends StatelessWidget {
  /// Emoji représentant la récompense (ex : 🍨, 🎁).
  final String emoji;

  /// Nombre minimum de points requis pour débloquer la récompense.
  final int minPoints;

  /// Crée un widget [Gift].
  const Gift({super.key, required this.emoji, required this.minPoints});

  @override
  Widget build(BuildContext context) {
    return Consumer<FortuneWheelController>(
      builder: (context, fortuneWheel, child) {
        final isUnlocked = fortuneWheel.points >= minPoints;

        return Animate(
          effects: [
            if (isUnlocked)
              const ScaleEffect(
                begin: Offset(0.9, 0.9),
                end: Offset(1, 1),
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
          ],
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),

              // Vérifie si la récompense est débloquée et
              //change couleur selon l'état
              color: (isUnlocked)
                  ? context.colorSchema.tertiaryContainer
                  : context.colorSchema.surfaceContainerHighest,
            ),
            child: Column(
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 5),

                // Texte indiquant le seuil de points requis
                Text(
                  '$minPoints pts',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: (fortuneWheel.points > minPoints)
                        ? context.colorSchema.onTertiaryContainer
                        : context.colorSchema.onTertiaryContainer,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
