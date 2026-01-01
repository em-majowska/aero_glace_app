import 'package:flutter/material.dart';

class Prize extends StatelessWidget {
  final String result;
  final bool isDiscount;
  const Prize({
    super.key,
    required this.result,
    required this.isDiscount,
  });

  @override
  Widget build(BuildContext context) {
    final String phrase = (isDiscount)
        ? '$result de réduction'
        : '${result.substring(0, 2)} points';

    return Center(
      child: Column(
        spacing: 8,
        children: [
          const Text('Vous avez gagné'),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              phrase,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onPrimaryFixedVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
