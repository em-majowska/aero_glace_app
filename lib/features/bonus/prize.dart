import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

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
        ? FlutterI18n.translate(context, "reduction")
        : FlutterI18n.translate(context, "result-points");

    return Center(
      child: Column(
        spacing: 8,
        children: [
          Text(FlutterI18n.translate(context, "vous-avez-gagne")),
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
