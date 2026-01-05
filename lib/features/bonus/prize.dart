import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Prize extends StatelessWidget {
  final int result;
  final bool isDiscount;
  const Prize({
    super.key,
    required this.result,
    required this.isDiscount,
  });

  @override
  Widget build(BuildContext context) {
    final String phrase = (isDiscount)
        ? context.tr('reduction', namedArgs: {'result': result.toString()})
        : context.tr('result_points', namedArgs: {'result': result.toString()});

    return Center(
      child: Column(
        spacing: 8,
        children: [
          Text(context.tr('vous_avez_gagne')),
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
