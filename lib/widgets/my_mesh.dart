import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class MyMesh extends StatelessWidget {
  final List<Color> meshColors;
  final AnimatedMeshGradientController? controller;

  const MyMesh({
    super.key,
    required this.meshColors,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedMeshGradient(
      options: AnimatedMeshGradientOptions(
        speed: 5,
        amplitude: 10,
        frequency: 5,
      ),
      colors: meshColors,
      controller: controller,
      child: Container(),
    );
  }
}
