import 'package:aero_glace_app/utils/animations.dart';
import 'package:aero_glace_app/utils/context_extensions.dart';
import 'package:blobs/blobs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:text_gradiate/text_gradiate.dart';

/// Classe regroupant les éléments graphiques animés “héro”
/// utilisés sur la page À propos.
///
/// Chaque méthode retourne un [Widget] positionné et éventuellement animé.
///
/// Arguments :
/// - [context] : le BuildContext permettant d'accéder aux dimensions de l'écran et au thème.
/// - [animated] : indique si l'icône doit jouer son animation immédiatement.
class HeroElement {
  // Icônes décoratives
  // Bas-gauche
  Widget icon_1(BuildContext context, bool animated) {
    final content = Positioned(
      left: context.mediaWidth * 0.1,
      bottom: context.mediaHeight * 0.07,
      child: Icon(LucideIcons.sparkles100, size: context.mediaHeight * 0.1),
    );

    if (animated) {
      return content
          .animate(onPlay: (controller) => controller.repeat())
          .shimmer(delay: 4.seconds);
    } else {
      return content
          .animate(delay: 600.ms, effects: scaleElastic)
          .swap(
            builder: (_, child) => child!
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(delay: 4.seconds),
          );
    }
  }

  // Haut-droite
  Widget icon_2(BuildContext context, bool animated) {
    final content = Positioned(
      right: context.mediaWidth * 0.1,
      top: context.mediaHeight * 0.17,
      child: Icon(
        LucideIcons.sparkle100,
        size: context.mediaHeight * 0.08,
      ),
    );
    if (animated) {
      return content
          .animate(onComplete: (controller) => controller.repeat())
          .shimmer(delay: 6.seconds);
    } else {
      return content
          .animate(delay: 300.ms, effects: scaleElastic)
          .swap(
            builder: (_, child) => child!
                .animate(onComplete: (controller) => controller.repeat())
                .shimmer(delay: 6.seconds),
          );
    }
  }

  // Étoiles décoratives
  // Étoile haute-gauche
  Widget star_1(BuildContext context, bool animated) {
    final content = Positioned(
      top: context.mediaHeight * 0.05,
      left: 0,
      child: Blur(
        blur: 2,
        child: RotatedBox(
          quarterTurns: -1,
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(
              const Size(400, 400),
            ),
            child: Image.asset(
              'assets/images/star.png',
              width: context.mediaWidth * 0.4,
            ),
          ),
        ),
      ),
    );

    if (animated) {
      return content;
    } else {
      return content
          .animate(
            onInit: (controller) => controller.repeat(max: 1, count: 1),
            effects: starBstart,
          )
          .swap(
            builder: (_, child) => child!.animate(effects: starBend),
          );
    }
  }

  // Étoile bas-droite
  Widget star_2(BuildContext context, bool animated) {
    final content = Positioned(
      bottom: context.mediaHeight * 0.1,
      right: context.mediaWidth * 0.2,
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(const Size(150, 150)),
        child: Image.asset(
          'assets/images/star.png',
          width: context.mediaWidth * 0.15,
        ),
      ),
    );

    if (animated) {
      return content;
    } else {
      return content.animate(delay: 500.ms, effects: starA);
    }
  }

  // Éléments centraux

  Widget circleBig(BuildContext context, bool animated) {
    final content = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(const Size(400, 400)),
        child: Container(
          width: context.mediaWidth * 0.6,
          height: context.mediaWidth * 0.6,
          decoration: BoxDecoration(
            color: const Color(0x00000000).withValues(alpha: 0.10),
            border: Border.all(
              color: const Color(
                0x00000000,
              ).withValues(alpha: 0.70),
            ),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
    if (animated) {
      return content;
    } else {
      return content.animate(delay: 200.ms, effects: scaleElastic);
    }
  }

  Widget circleSmall(BuildContext context, bool animated) {
    final content = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(const Size(350, 350)),
        child: Container(
          width: context.mediaWidth * 0.5,
          height: context.mediaWidth * 0.5,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF).withValues(alpha: 0.40),
            border: Border.all(
              color: Colors.white,
            ),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );

    if (animated) {
      return content;
    } else {
      return content.animate(delay: 800.ms, effects: scaleElastic);
    }
  }

  Widget text(BuildContext context, bool animated) {
    final content = Positioned(
      left: 0,
      right: 0,
      bottom: context.mediaHeight / 4.5,
      child: TextGradiate(
        text: Text(
          context.tr('hero_text'),
          style: context.textTheme.bodyLarge?.copyWith(
            fontSize: context.mediaWidth * 0.07,
          ),
          textAlign: TextAlign.center,
        ),
        colors: [
          context.colorSchema.secondaryContainer,
          context.colorSchema.onSurface,
        ],
        gradientType: GradientType.linear,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );

    if (animated) {
      return content;
    } else {
      return content.animate(delay: 3500.ms).fadeIn(duration: 1.seconds);
    }
  }

  Widget iceCream(BuildContext context, bool animated) {
    final content = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(
          const Size(450, 450),
        ),
        child: Image.asset(
          'assets/images/ice-cream.png',
          width: context.mediaWidth * 0.35,
        ),
      ),
    );

    if (animated) {
      return content;
    } else {
      return content
          .animate(delay: 1.seconds, effects: iceCreamA)
          .swap(
            builder: (_, child) => child!.animate(
              onPlay: (controller) => controller.repeat(reverse: true),
              effects: iceCreamB,
            ),
          );
    }
  }

  // Blobs décoratifs
  // Blob haut-droite (contour)
  Widget blob_1(BuildContext context) {
    return Positioned(
      top: context.mediaHeight * -0.13,
      right: context.mediaWidth * -0.2,
      child: Blob.random(
        // size: 400,
        size: context.mediaWidth * 0.8,
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
    );
  }

  // Blob haut-gauche (plein)
  Widget blob_2(BuildContext context) {
    return Positioned(
      top: context.mediaHeight * -0.2,
      left: context.mediaWidth * -0.4,
      child: Blob.random(
        size: context.mediaHeight * 0.65,
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
    );
  }

  // Blob bas-droite (plein)
  Widget blob_3(BuildContext context) {
    return Positioned(
      bottom: context.mediaHeight * -0.15,
      right: context.mediaWidth * -0.4,
      child: Blob.random(
        size: context.mediaHeight * 0.45,
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
    );
  }

  // Blob bas-gauche (contour)
  Widget blob_4(BuildContext context) {
    return Positioned(
      bottom: context.mediaHeight * -0.17,
      left: context.mediaWidth * -0.45,
      child: Blob.random(
        size: context.mediaHeight * 0.45,
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
    );
  }
}
