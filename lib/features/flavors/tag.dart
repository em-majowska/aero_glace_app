import 'package:aero_glace_app/util/theme.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String tag;
  const Tag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: context.colorSchema.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: context.colorSchema.onSurface,
          fontSize: 10,
        ),
      ),
    );
  }
}
