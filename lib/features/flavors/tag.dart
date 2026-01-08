import 'package:aero_glace_app/util/theme.dart';
import 'package:flutter/material.dart';

/// Widget affichant une étiquette avec un style spécifique.
///
/// Argument :
/// - [tag] : texte du tag à afficher.
/// L'element issu de la liste `tags` d'un [Flavor].
class Tag extends StatelessWidget {
  /// Libellé du tag à afficher.
  final String tag;

  /// Crée un widget [Tag] avec le texte fourni.
  const Tag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: context.colorSchema.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: context.colorSchema.onSurface,
          fontSize: 10,
        ),
      ),
    );
  }
}
