import 'package:flutter/material.dart';

class MyBackground extends StatelessWidget {
  final String assetPath;

  const MyBackground({
    super.key,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$assetPath',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
