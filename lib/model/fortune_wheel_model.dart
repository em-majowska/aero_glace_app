// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aero_glace_app/util/next_day.dart';

class FortuneWheelModel extends ChangeNotifier {
  late final Box _wheelBox;
  int _outcome = 0;
  bool _isWheelActive = true;
  DateTime _date = DateTime.now();

  final List<String> _discounts = [
    '20 pts',
    '10%',
    '15%',
    '20%',
    '50 pts',
    '10%',
    '15%',
    '20%',
  ];

  FortuneWheelModel() {
    _wheelBox = Hive.box('fortuneBox');
    _loadState();
  }

  void _loadState() {
    final state = _wheelBox.get('state');

    if (state != null) {
      _outcome = state['outcome'] ?? _outcome;
      _isWheelActive = state['isWheelActive'] ?? _isWheelActive;
      _date = state['date'] ?? _date;
    }

    if (isNextDay()) {
      _isWheelActive = true;
    }

    notifyListeners();
  }

  void updateState() {
    _wheelBox.put('state', {
      'outcome': _outcome,
      'isWheelActive': _isWheelActive,
      'date': _date,
    });

    notifyListeners();
  }

  List<String> get discounts => _discounts;
  int get outcome => _outcome;
  set outcome(int randomValue) => _outcome;
  bool get isWheelActive => _isWheelActive;

  bool isOutcomeDiscount(String result) {
    final n = result.substring(result.length - 1);
    return (n == '%') ? true : false;
  }

  void disableWheel() {
    _isWheelActive = false;
    _date = DateTime.now();
    updateState();
  }
}
