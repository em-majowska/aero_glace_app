import 'package:mesh_gradient/mesh_gradient.dart';

class Flavor {
  final int id;
  final String title;
  final String description;
  final List<String> tags;
  final String imagePath;
  final double price;
  final List<MeshGradientPoint> meshPoints;

  Flavor({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.imagePath,
    required this.price,
    required this.meshPoints,
  });
}
