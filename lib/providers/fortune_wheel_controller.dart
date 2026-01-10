// import 'dart:async';
import 'dart:math';
import 'package:aero_glace_app/models/hive_fidelity_level.dart';
import 'package:aero_glace_app/models/hive_fortune_result.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aero_glace_app/utils/next_day.dart';

/// Contrôleur gérant la roue de la fortune et le système de fidélité.
///
/// Ce contrôleur utilise **Hive** pour persister l'état de la roue,
/// les points collectés, les niveaux de fidélité et la roue
class FortuneWheelController extends ChangeNotifier {
  /// Boîte **Hive** utilisée pour persister l'état de la roue.
  late final Box _fortuneBox;

  /// Index aléatoire de l'élément sélectionné sur la roue.
  late int _random = 0;

  /// Résultat du dernier tirage de la roue.
  late HiveFortuneResult _result = HiveFortuneResult(
    value: 0,
    type: 'discount',
  );

  /// Indique si la roue peut être utilisée aujourd'hui.
  bool _isWheelActive = true;

  /// Date du dernier tirage.
  DateTime _date = DateTime.now();

  /// Points de fidélité collectés par l'utilisateur.
  int _points = 0;

  /// Niveau actuel de fidélité.
  HiveFidelityLevel _level = HiveFidelityLevel(
    value: 1,
    minPoints: 0,
    maxPoints: 250,
  );

  /// Liste des niveaux de fidélité.
  final List<HiveFidelityLevel> _levels = [
    HiveFidelityLevel(value: 1, minPoints: 0, maxPoints: 250),
    HiveFidelityLevel(value: 2, minPoints: 251, maxPoints: 500),
    HiveFidelityLevel(value: 3, minPoints: 501, maxPoints: 1000),
    HiveFidelityLevel(value: 4, minPoints: 1001, maxPoints: 1500),
  ];

  /// Liste des résultats possibles de la roue.
  final List<HiveFortuneResult> _fortuneItems = [
    HiveFortuneResult(value: 10, type: 'discount'),
    HiveFortuneResult(value: 15, type: 'discount'),
    HiveFortuneResult(value: 20, type: 'discount'),
    HiveFortuneResult(value: 10, type: 'points'),
    HiveFortuneResult(value: 20, type: 'points'),
    HiveFortuneResult(value: 30, type: 'points'),
    HiveFortuneResult(value: 40, type: 'points'),
    HiveFortuneResult(value: 50, type: 'points'),
  ];

  /// Retourne l'index aléatoire de l'élément sélectionné.
  int get random => _random;

  /// Retourne si la roue peut être utilisée.
  bool get isWheelActive => _isWheelActive;

  /// Retourne le résultat actuel de la roue.
  HiveFortuneResult get result => _result;

  /// Retourne la liste dees éléments de la roue.
  List<HiveFortuneResult> get fortuneItems => _fortuneItems;

  /// Retourne les points de fidélité collectés.
  int get points => _points;

  /// Retourne le niveau de fidélité actuel.
  HiveFidelityLevel get level => _level;

  /// Crée le contrôleur et charge l'état depuis **Hive**.
  FortuneWheelController() {
    _fortuneBox = Hive.box('fortuneBox');
    _loadState();
  }

  /// Charge l'état de la roue et des points depuis **Hive**.
  void _loadState() {
    final state = _fortuneBox.get('status');
    final fortuneresult = _fortuneBox.get('result');
    final collectedPoints = _fortuneBox.get('points');
    final gainedLevel = _fortuneBox.get('level');

    if (fortuneresult != null) _result = fortuneresult;
    if (collectedPoints != null) _points = collectedPoints;
    if (gainedLevel != null) _level = gainedLevel;

    if (state != null) {
      final dateString = state['date'];

      _isWheelActive = state['isWheelActive'] ?? _isWheelActive;
      if (dateString != null) _date = DateTime.tryParse(dateString) ?? _date;
      if (isNextDay(_date)) _isWheelActive = true;
    }

    // Mélange la liste des éléments de la roue.
    _fortuneItems.shuffle();
    updateWheel();
  }

  /// Sélectionne un élément aléatoire de la roue et met à jour [_result].
  void getRandomFortuneItem() {
    _random = Random().nextInt(fortuneItems.length);
    _result = fortuneItems[_random];
    _fortuneBox.put('result', _result);

    updateWheel();
  }

  /// Met à jour l'état de la roue dans Hive et notifie les widgets.
  void updateWheel() {
    _fortuneBox.put('status', {
      'isWheelActive': _isWheelActive,
      'date': _date.toIso8601String(),
    });

    notifyListeners();
  }

  /// Met à jour les points et le niveau dans **Hive** et notifie les widgets.
  void updatePoints() {
    _fortuneBox.put('points', _points);
    _fortuneBox.put('level', _level);

    notifyListeners();
  }

  /// Retourne la valeur à afficher sur la roue pour un élément donné.
  ///
  /// - `item.type == 'discount'` : retourne la valeur avec `%`.
  /// - `item.type == 'points'` : retourne la valeur avec `pts`.
  String displayValue(HiveFortuneResult item) {
    return (item.type == 'discount') ? '${item.value}%' : '${item.value} pts';
  }

  /// Désactive la roue et sauvegarde la date de tirage.
  void disableWheel(DateTime date) {
    _date = date;
    _isWheelActive = false;
    updateWheel();
  }

  /// Ajoute des points de fidélité et met à jour le niveau.
  void addPoints(int result) {
    _points += result;
    _setLevel();

    updatePoints();
  }

  /// Détermine le niveau actuel en fonction du total des points.
  void _setLevel() {
    (_points < 250)
        ? _level = _levels[0]
        : (_points < 500)
        ? _level = _levels[1]
        : (_points < 1000)
        ? _level = _levels[2]
        : _level = _levels[3];
  }
}
