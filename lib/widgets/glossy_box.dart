import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

/// Conteneur décoratif avec un effet "verre".
///
/// Argument :
/// - [child] : contenu affiché à l’intérieur du conteneur glossy.
/// - [width], [height] sont optionnels.
class GlossyBox extends StatelessWidget {
  /// Contenu affiché à l’intérieur du conteneur glossy.
  final Widget child;
  final double? width;
  final double? height;

  /// Crée un widget [GlossyBox].
  const GlossyBox({
    super.key,
    required this.child,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // Empêche le débordement du contenu
          width: width,
          height: height,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),

            // Bordure avec effet lumineux en dégradé
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFffffff).withValues(alpha: 0.95),
                  const Color(0xFFFFFFFF).withValues(alpha: 0.75),
                ],
              ),
            ),

            // Fond semi-transparent avec dégradé doux
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withValues(alpha: 0.95),
                const Color(0xFFFFFFFF).withValues(alpha: 0.55),
              ],
              stops: [
                0.1,
                1,
              ],
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}
