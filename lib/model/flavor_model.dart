import 'package:mesh_gradient/mesh_gradient.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive/hive.dart';

// part 'flavor.g.dart';

// @HiveType(typeId: 0)
class Flavor {
  final int id;
  final String title;
  final String description;
  final List<String> tags;
  final String imagePath;
  final double price;
  final List<MeshGradientPoint> meshPoints;
  int qty;

  Flavor({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.imagePath,
    required this.price,
    required this.meshPoints,
    this.qty = 0,
  });

  static const typeId = 0;
}

// generate with 'dart run build_runner build' command
