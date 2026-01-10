import 'package:hive_flutter/hive_flutter.dart';

// generate with 'dart run build_runner build' command
part 'hive_fortune_result.g.dart';

/// Représente un résultat possible de la roue de la fortune.
///
/// Chaque résultat peut être soit une remise (`discount`) soit des points de fidélité (`points`).
/// Cette classe est persistée dans Hive avec [HiveType] et [HiveField] pour la sauvegarde locale.
@HiveType(typeId: 1)
class HiveFortuneResult extends HiveObject {
  /// Valeur associée au résultat.
  ///
  /// - Si [type] est `'discount'`, c’est un pourcentage de réduction.
  /// - Si [type] est `'points'`, c’est le nombre de points de fidélité gagnés.
  @HiveField(0)
  int value;

  /// Type du résultat : `'discount'` ou `'points'`.
  @HiveField(1)
  final String type;

  /// Crée un résultat de la roue avec sa valeur et son type.
  HiveFortuneResult({
    required this.value,
    required this.type,
  });
}
