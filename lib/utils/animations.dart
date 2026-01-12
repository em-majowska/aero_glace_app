import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Effets d'animation personnalisés pour l'application Aero Glace,
/// utilisant le package [flutter_animate](https://pub.dev/packages/flutter_animate)
/// pour un rendu visuel dynamique et futuriste.
final List<Effect> scaleElastic = <Effect>[
  ScaleEffect(
    duration: 1000.ms,
    curve: Curves.easeOutBack,
  ),
];

final List<Effect> slideIn = <Effect>[
  FadeEffect(duration: 400.ms),
  SlideEffect(
    begin: const Offset(-0.7, 0),
    end: const Offset(0, 0),
    curve: Curves.easeOut,
    duration: 400.ms,
  ),
];

final List<Effect> iceCreamA = <Effect>[
  FadeEffect(
    curve: Curves.linear,
    duration: 1.seconds,
  ),
  ScaleEffect(
    curve: Curves.easeInOut,
    begin: const Offset(0, 0),
    end: const Offset(1, 1),
    duration: 2.seconds,
  ),
  ShimmerEffect(delay: 1.seconds),
];

final List<Effect> iceCreamB = <Effect>[
  ScaleEffect(
    curve: Curves.easeInOut,
    begin: const Offset(1, 1),
    end: const Offset(0.9, 0.9),
    duration: 3.seconds,
  ),
];

final List<Effect> starA = <Effect>[
  SlideEffect(
    curve: Curves.fastLinearToSlowEaseIn,
    duration: 1200.ms,
    begin: const Offset(1, 2),
    end: const Offset(0, 0),
  ),
  ScaleEffect(
    curve: Curves.fastLinearToSlowEaseIn,
    duration: 1200.ms,
  ),
];

final List<Effect> starBstart = <Effect>[
  RotateEffect(
    begin: 0,
    end: 0.5,
    duration: 25.seconds,
    curve: Curves.linear,
  ),
  SlideEffect(
    begin: const Offset(-1.5, 0),
    end: const Offset(3, 0),
    duration: 25.seconds,
    curve: Curves.easeOut,
  ),
];

final List<Effect> starBend = <Effect>[
  RotateEffect(
    begin: 0,
    end: 0.2,
    duration: 5.seconds,
    curve: Curves.linear,
  ),
  SlideEffect(
    begin: const Offset(-1.5, 0),
    end: const Offset(0, 0),
    duration: 5.seconds,
    curve: Curves.easeOut,
  ),
];
