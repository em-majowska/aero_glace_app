import 'package:aero_glace_app/features/bonus/collected_points_tile.dart';
import 'package:aero_glace_app/features/bonus/fortune_wheel_tile.dart';
import 'package:aero_glace_app/utils/theme.dart';
import 'package:aero_glace_app/widgets/language_menu_btn.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Page affichant la section bonus de l’application.
///
/// Retourne un [Scaffold] contenant une [AppBar] incluant
/// un sélecteur de langue et :
/// - les points collectés par l’utilisateur [CollectedPoints],
/// - une roue de la fortune permettant d’obtenir des récompenses
/// [FortuneWheelTile].
class BonusPage extends StatelessWidget {
  // Crée la page de bonus
  const BonusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('bonus'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [const LanguageMenuButton()],
        backgroundColor: context.colorSchema.surface,
        scrolledUnderElevation: 0.0,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const MyBackground(assetPath: 'background3.jpg'),
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Points de fidélité, niveau actuel et les récompenses
              const CollectedPoints().animate(delay: 200.ms).fadeIn(),
              const SizedBox(height: 32),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 24,
                children: [
                  Icon(LucideIcons.sparkles200, size: 24),
                  Icon(LucideIcons.sparkles200, size: 24),
                  Icon(LucideIcons.sparkles200, size: 24),
                ],
              ),
              const SizedBox(height: 32),

              // Widget de la roue de la fortune
              const FortuneWheelTile().animate(delay: 400.ms).fadeIn(),
            ],
          ),
        ],
      ),
    );
  }
}
