import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

/// Widget affichant un dégradé animé en maillage.
///
/// Utile pour décorer l’arrière-plan d’un [FlavorTile] ou tout autre élément
/// nécessitant un effet visuel dynamique.
///
/// Arguments :
/// - [meshColors] : liste de couleurs utilisées pour générer le dégradé animé.
/// - [controller] : contrôleur optionnel permettant de démarrer ou arrêter l’animation.
class MyMesh extends StatelessWidget {
  /// Liste de couleurs utilisées pour générer le dégradé animé (4 couleurs requis).
  final List<Color> meshColors;

  /// Contrôleur optionnel permettant de démarrer ou arrêter l’animation.
  final AnimatedMeshGradientController? controller;

  /// Crée le fond dégradé animé en maillage [MyMesh].
  const MyMesh({
    super.key,
    required this.meshColors,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedMeshGradient(
      options: AnimatedMeshGradientOptions(
        speed: 5,
        amplitude: 10,
        frequency: 5,
      ),
      colors: meshColors,
      controller: controller,
      child: Container(),
    );
  }
}
