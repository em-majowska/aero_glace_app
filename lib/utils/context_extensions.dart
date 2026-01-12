import 'package:flutter/material.dart';

extension MyThemeExtension on BuildContext {
  ColorScheme get colorSchema => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension MediaQueryExtension on BuildContext {
  double get mediaWidth => MediaQuery.of(this).size.width;
  double get mediaHeight => MediaQuery.of(this).size.height;
}
