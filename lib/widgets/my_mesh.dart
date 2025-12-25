import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class MyMesh extends StatelessWidget {
  final dynamic child;
  final List<MeshGradientPoint> meshPoints;

  const MyMesh({super.key, this.child, required this.meshPoints});

  @override
  Widget build(BuildContext context) {
    return MeshGradient(
      options: MeshGradientOptions(blend: 3, noiseIntensity: 0.3),
      points: meshPoints,
      child: child,
    );
  }
}
