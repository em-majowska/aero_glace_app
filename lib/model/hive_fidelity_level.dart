import 'package:hive_flutter/hive_flutter.dart';

// generate with 'dart run build_runner build' command
part 'hive_fidelity_level.g.dart';

/// Représente un niveau de fidélité pour l'utilisateur.
///
/// Arguments :
/// - [value] : le numéro du niveau (ex: 1, 2, 3…).
/// - [minPoints] : le nombre minimum de points requis pour atteindre ce niveau.
/// - [maxPoints] : le nombre maximum de points de ce niveau avant de passer au niveau suivant.
///
/// Cette classe est persistée dans Hive avec [HiveType] et [HiveField] pour la sauvegarde locale.
@HiveType(typeId: 2)
class HiveFidelityLevel extends HiveObject {
  /// Numéro du niveau de fidélité.
  @HiveField(0)
  final int value;

  /// Points minimum requis pour ce niveau.
  @HiveField(1)
  final int minPoints;

  /// Points maximum pour ce niveau.
  @HiveField(2)
  final int maxPoints;

  /// Crée un niveau de fidélité avec ses valeurs associées.
  HiveFidelityLevel({
    required this.value,
    required this.minPoints,
    required this.maxPoints,
  });
}
