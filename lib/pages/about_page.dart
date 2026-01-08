import 'package:aero_glace_app/widgets/language_menu_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:blobs/blobs.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Page “À propos” de l’application.
class AboutPage extends StatelessWidget {
  /// Crée la page "À propos"
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('aero_glace')),
        actions: [const LanguageMenuButton()],
      ),
      body: Stack(
        children: [
          // Arrière-plan principal
          const MyBackground(assetPath: 'background.jpg'),

          // Blobs décoratifs
          // Blob haut-droite (contour)
          Positioned(
            top: mediaHeight * -0.13,
            right: mediaWidth * -0.2,
            child: Blob.random(
              // size: 400,
              size: mediaWidth * 0.8,
              edgesCount: 15,
              styles: BlobStyles(
                fillType: BlobFillType.stroke,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFffffff).withValues(alpha: 0.95),
                    const Color(0xFFFFFFFF).withValues(alpha: 0.70),
                  ],
                ).createShader(const Rect.fromLTRB(0, 0, 100, 100)),
                strokeWidth: 2,
              ),
            ),
          ),

          // Blob haut-gauche (plein)
          Positioned(
            top: mediaHeight * -0.2,
            left: mediaWidth * -0.4,
            child: Blob.random(
              size: 500,
              edgesCount: 10,
              styles: BlobStyles(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFffffff).withValues(alpha: 0.35),
                    const Color(0xFFFFFFFF).withValues(alpha: 0.50),
                  ],
                ).createShader(const Rect.fromLTRB(0, 0, 100, 100)),
              ),
            ),
          ),

          // Blob bas-droite (plein)
          Positioned(
            bottom: mediaHeight * -0.15,
            right: mediaWidth * -0.4,
            child: Blob.random(
              size: mediaHeight * 0.45,
              edgesCount: 20,
              styles: BlobStyles(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFffffff).withValues(alpha: 0.35),
                    const Color(0xFFFFFFFF).withValues(alpha: 0.50),
                  ],
                ).createShader(const Rect.fromLTRB(0, 0, 100, 100)),
              ),
            ),
          ),
          // TODO animations

          // Blob bas-gauche (contour)
          Positioned(
            bottom: mediaHeight * -0.17,
            left: mediaWidth * -0.45,
            child: Blob.random(
              size: mediaHeight * 0.45,
              edgesCount: 15,
              styles: BlobStyles(
                fillType: BlobFillType.stroke,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFffffff).withValues(alpha: 0.95),
                    const Color(0xFFFFFFFF).withValues(alpha: 0.70),
                  ],
                ).createShader(const Rect.fromLTRB(0, 0, 100, 100)),
                strokeWidth: 2,
              ),
            ),
          ),

          // Icônes décoratives
          // Bas-gauche
          Positioned(
            left: mediaWidth * 0.1,
            bottom: mediaHeight * 0.07,
            child: Icon(LucideIcons.sparkles100, size: mediaHeight * 0.1),
          ),

          // Haut-droite
          Positioned(
            right: mediaWidth * 0.1,
            top: mediaHeight * 0.17,
            child: Icon(LucideIcons.sparkle100, size: mediaHeight * 0.08),
          ),

          // Étoiles décoratives
          // Étoile haute-gauche
          Positioned(
            top: mediaHeight * 0.05,
            left: 0,
            child: Blur(
              blur: 2,
              child: RotatedBox(
                quarterTurns: -1,
                child: ConstrainedBox(
                  constraints: BoxConstraints.loose(const Size(400, 400)),
                  child: Image.asset(
                    'assets/images/star.png',
                    width: mediaWidth * 0.4,
                  ),
                ),
              ),
            ),
          ),

          // Étoile bas-droite
          Positioned(
            bottom: mediaHeight * 0.1,
            right: mediaWidth * 0.2,
            child: ConstrainedBox(
              constraints: BoxConstraints.loose(const Size(150, 150)),
              child: Image.asset(
                'assets/images/star.png',
                width: mediaWidth * 0.15,
              ),
            ),
          ),

          // Éléments centraux
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.loose(const Size(400, 400)),
              child: Container(
                width: mediaWidth * 0.6,
                height: mediaWidth * 0.6,
                decoration: BoxDecoration(
                  color: const Color(0x00000000).withValues(alpha: 0.10),
                  border: Border.all(
                    color: const Color(0x00000000).withValues(alpha: 0.70),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.loose(const Size(350, 350)),
              child: Container(
                width: mediaWidth * 0.5,
                height: mediaWidth * 0.5,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.40),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.loose(const Size(450, 450)),
              child: Image.asset(
                'assets/images/ice-cream.png',
                width: mediaWidth * 0.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
