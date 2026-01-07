// import 'dart:async';
import 'dart:math';
import 'package:aero_glace_app/model/hive_fidelity_level.dart';
import 'package:aero_glace_app/model/hive_fortune_result.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aero_glace_app/util/next_day.dart';

class FortuneWheelController extends ChangeNotifier {
  late final Box _fortuneBox;
  late int _random = 0;
  late HiveFortuneResult _result = HiveFortuneResult(
    value: 0,
    type: 'discount',
  );
  bool _isWheelActive = true;
  DateTime _date = DateTime.now();
  int _points = 0;
  HiveFidelityLevel _level = HiveFidelityLevel(
    value: 1,
    minPoints: 0,
    maxPoints: 250,
  );

  final List<HiveFidelityLevel> _levels = [
    HiveFidelityLevel(value: 1, minPoints: 0, maxPoints: 250),
    HiveFidelityLevel(value: 2, minPoints: 251, maxPoints: 500),
    HiveFidelityLevel(value: 3, minPoints: 501, maxPoints: 1000),
    HiveFidelityLevel(value: 4, minPoints: 1001, maxPoints: 1500),
  ];

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

  int get random =>
      _random; // to add as index to the controller of fortune wheel
  bool get isWheelActive => _isWheelActive;
  HiveFortuneResult get result => _result; // to keep in hive
  List<HiveFortuneResult> get fortuneItems => _fortuneItems;
  int get points => _points;
  HiveFidelityLevel get level => _level;

  FortuneWheelController() {
    _fortuneBox = Hive.box('fortuneBox');

    _loadState();
  }

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

    shuffleItemsList();
    updateWheel();
  }

  void shuffleItemsList() {
    _fortuneItems.shuffle();
  }

  void getRandomFortuneItem() {
    _random = Random().nextInt(fortuneItems.length);
    _result = fortuneItems[_random];
    _fortuneBox.put('result', _result);

    updateWheel();
  }

  void updateWheel() {
    _fortuneBox.put('status', {
      'isWheelActive': _isWheelActive,
      'date': _date.toIso8601String(),
    });

    notifyListeners();
  }

  void updatePoints() {
    _fortuneBox.put('points', _points);
    _fortuneBox.put('level', _level);

    notifyListeners();
  }

  void randomizeItems() {
    _fortuneItems.shuffle();
  }

  // string values to display on fortune wheel
  String displayValue(HiveFortuneResult item) {
    return (item.type == 'discount') ? '${item.value}%' : '${item.value} pts';
  }

  // save spinning date and disable till next day
  void disableWheel(DateTime date) {
    _date = date;
    _isWheelActive = false;
    updateWheel();
  }

  // Collecting points

  void addPoints(int result) {
    _points += result;
    _setLevel();

    updatePoints();
  }

  void _setLevel() {
    (_points < 250)
        ? _level = _levels[0]
        : (_points < 500)
        ? _level = _levels[1]
        : (_points < 1000)
        ? _level = _levels[2]
        : _level = _levels[3];
  }

  // worked if controller.add didn't need an int
  // HiveFortuneResult getRandomFortuneItem() {
  //   final totalWeight = fortuneItems.fold(0, (sum, item) => sum + item.weight);
  //   final random = Random().nextInt(totalWeight);
  //   int cumulativeWeight = 0;

  //   for (final item in fortuneItems) {
  //     cumulativeWeight += item.weight;
  //     if (random < cumulativeWeight) {
  //       return item;
  //     }
  //   }

  //   return fortuneItems.first;
  // }
}
