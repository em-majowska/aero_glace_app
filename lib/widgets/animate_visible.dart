import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Widget qui anime son enfant lorsqu'il devient visible à l'écran.
///
/// [AnimateOnVisible] permet de déclencher des animations uniquement
/// lorsque le widget est affiché à l'utilisateur. Utile pour
/// des effets “fade in” ou “slide in” sur des éléments scrolables.
///
/// Arguments :
/// - [child] : le widget à animer.
/// - [delay] : délai après l’animation initiale avant que la chaîne d’animations suivantes se déclenche.
class AnimateOnVisible extends StatefulWidget {
  final Widget child;
  final Duration delay;
  const AnimateOnVisible({
    super.key,
    required this.child,
    this.delay = const Duration(milliseconds: 500),
  });

  @override
  State<AnimateOnVisible> createState() => _AnimateOnVisibleState();
}

class _AnimateOnVisibleState extends State<AnimateOnVisible> {
  // Indique si l'animation a déjà été déclenchée
  bool _animated = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(),

      /// Callback appelé lorsque la visibilité du widget change
      onVisibilityChanged: (info) {
        if (!_animated && info.visibleFraction > 0.9) {
          setState(() {
            _animated = true;
          });
        }
      },

      // Affichage conditionnel : animation si visible, sinon transparent
      child: _animated
          ? widget.child
                .animate(
                  effects: [
                    FadeEffect(duration: 500.ms, curve: Curves.easeInOut),
                    SlideEffect(
                      duration: 700.ms,
                      curve: Curves.easeInOut,
                      begin: const Offset(0, 0.2),
                      end: const Offset(0, 0),
                    ),
                  ],
                )
                .then(delay: widget.delay)
          : Opacity(opacity: 0, child: widget.child),
    );
  }
}
