import 'package:flutter/material.dart';

/// Widget affichant une image de fond décorative.
///
/// Argument :
/// - [assetPath] : le chemin de l’image relatif au dossier `assets/images/`.
class MyBackground extends StatelessWidget {
  /// Le chemin de l’image relatif au dossier `assets/images/`.
  final String assetPath;

  const MyBackground({
    super.key,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$assetPath',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
