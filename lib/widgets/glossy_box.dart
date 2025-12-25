import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class GlossyBox extends StatelessWidget {
  final Widget child;

  const GlossyBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFffffff).withValues(alpha: 0.95),
                  const Color(0xFFFFFFFF).withValues(alpha: 0.75),
                ],
              ),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withValues(alpha: 0.75),
                const Color(0xFFFFFFFF).withValues(alpha: 0.25),
              ],
              stops: [
                0.1,
                1,
              ],
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}
