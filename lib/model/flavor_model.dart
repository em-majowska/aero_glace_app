import 'package:flutter/material.dart';

class Flavor {
  final int id;
  final String title;
  final String description;
  final List<String> tags;
  final String imagePath;
  final double price;
  final List<Color> meshColors;

  Flavor({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.imagePath,
    required this.price,
    required this.meshColors,
  });
}
