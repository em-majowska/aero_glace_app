import 'package:aero_glace_app/model/fortune_wheel_controller.dart';
import 'package:aero_glace_app/util/theme.dart';
import 'package:flutter/material.dart';
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
        return Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),

              // Vérifie si la récompense est débloquée et
              //change couleur selon l'état
              color: (fortuneWheel.points >= minPoints)
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
