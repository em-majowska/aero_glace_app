// import 'dart:async';
import 'dart:math';
import 'package:aero_glace_app/model/hive_outcome_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aero_glace_app/util/next_day.dart';

class FortuneWheelModel extends ChangeNotifier {
  late final Box _fortuneBox;
  late int _random = 0; // fallback
  late HiveOutcome _outcome = HiveOutcome(
    value: 0,
    type: 'discount',
  ); // fallback
  bool _isWheelActive = true;
  DateTime _date = DateTime.now();

  final List<HiveOutcome> _fortuneItems = [
    HiveOutcome(value: 10, type: 'discount'),
    HiveOutcome(value: 15, type: 'discount'),
    HiveOutcome(value: 20, type: 'discount'),
    HiveOutcome(value: 10, type: 'points'),
    HiveOutcome(value: 20, type: 'points'),
    HiveOutcome(value: 30, type: 'points'),
    HiveOutcome(value: 40, type: 'points'),
    HiveOutcome(value: 50, type: 'points'),
  ];

  int get random =>
      _random; // to add as index to the controller of fortune wheel
  bool get isWheelActive => _isWheelActive;
  HiveOutcome get outcome => _outcome; // to keep in hive
  List<HiveOutcome> get fortuneItems => _fortuneItems;

  FortuneWheelModel() {
    _fortuneBox = Hive.box('fortuneBox');

    _loadState();
  }

  void _loadState() {
    final state = _fortuneBox.get('status');
    final fortuneOutcome = _fortuneBox.get('outcome');

    if (fortuneOutcome != null) _outcome = fortuneOutcome;
    if (state != null) {
      _isWheelActive = state['isWheelActive'] ?? _isWheelActive;
      _date = DateTime.tryParse(state['date']?.toString() ?? '') ?? _date;

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
    _outcome = fortuneItems[_random];
    _fortuneBox.put('outcome', _outcome);

    updateWheel();
  }

  void updateWheel() {
    _fortuneBox.put('status', {
      'isWheelActive': _isWheelActive,
      'date': _date.toIso8601String(),
    });

    notifyListeners();
  }

  void randomizeItems() {
    _fortuneItems.shuffle();
  }

  // string values to display on fortune wheel
  String displayValue(HiveOutcome item) {
    return (item.type == 'discount') ? '${item.value}%' : '${item.value} pts';
  }

  // save spinning date and disable till next day
  void disableWheel(DateTime date) {
    _date = date;
    _isWheelActive = false;
    updateWheel();
  }

  // worked if controller.add didn't need an int
  // HiveOutcome getRandomFortuneItem() {
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
