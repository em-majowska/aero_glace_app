// import 'dart:async';
import 'package:aero_glace_app/model/fortune_state.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FortuneWheelModel extends ChangeNotifier {
  late final Box _wheelBox;
  int _outcome = 0;
  bool _isWheelActive = true;

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
    }
  }

  void updateState() {
    _wheelBox.put('state', {
      'outcome': _outcome,
      'isWheelActive': _isWheelActive,
    });

    notifyListeners();
  }

  List<String> get discounts => _discounts;
  int get outcome => _outcome;
  set outcome(int randomValue) => _outcome;
  bool get isWheelActive => _isWheelActive;

  void disableWheel() {
    _isWheelActive = false;
    updateState();
  }

  bool isOutcomeDiscount(String result) {
    final n = result.substring(result.length - 1);
    return (n == '%') ? true : false;
  }
}
