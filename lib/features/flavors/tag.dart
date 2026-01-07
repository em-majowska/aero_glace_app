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
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 10,
        ),
      ),
    );
  }
}
