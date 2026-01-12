import 'package:aero_glace_app/features/about/hero_elements.dart';
import 'package:flutter/material.dart';

/// Widget regroupant tous les éléments “héro” animés pour la page À propos.
class HeroElements extends StatefulWidget {
  /// Crée le widget HeroElements
  const HeroElements({super.key});

  @override
  State<HeroElements> createState() => _HeroElementsState();
}

class _HeroElementsState extends State<HeroElements>
    with AutomaticKeepAliveClientMixin {
  final bool _animated = false;

  /// Permet de conserver l'état du widget même si la page est
  /// hors écran (préserve les animations et la position)
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    /// Retourne la liste de tous les widgets animés composant le Hero
    List<Widget> elements(BuildContext context) {
      return [
        /// Arguments :
        /// - [context] : le BuildContext permettant d'accéder aux dimensions de l'écran et au thème.
        /// - [animated] : indique si l'icône doit jouer son animation immédiatement.
        HeroElement().icon_1(context, _animated),
        HeroElement().icon_2(context, _animated),
        HeroElement().star_1(context, _animated),
        HeroElement().star_2(context, _animated),
        HeroElement().circleBig(context, _animated),
        HeroElement().circleSmall(context, _animated),
        HeroElement().text(context, _animated),
        HeroElement().iceCream(context, _animated),
      ];
    }

    // Retourne une pile de tous les éléments héroïques
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: elements(context),
    );
  }
}
