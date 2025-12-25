import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FortuneWheelElement extends StatefulWidget {
  const FortuneWheelElement({super.key});

  @override
  State<FortuneWheelElement> createState() => _FortuneWheelElementState();
}

class _FortuneWheelElementState extends State<FortuneWheelElement> {
  final StreamController<int> controller = StreamController<int>();
  final discounts = [
    '5%',
    '10%',
    '15%',
    '20%',
    '5%',
    '10%',
    '15%',
    '20%',
  ];

  final segmentColors = [
    Colors.blue.shade100,
    Colors.red.shade100,
  ];

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: FortuneWheel(
            selected: controller.stream,
            animateFirst: false,
            indicators: <FortuneIndicator>[
              FortuneIndicator(
                alignment: Alignment.topCenter,
                child: TriangleIndicator(
                  color: Theme.of(context).colorScheme.primary,
                  width: 25,
                  height: 25,
                  elevation: 3,
                ),
              ),
            ],
            items: List.generate(discounts.length, (i) {
              return FortuneItem(
                style: FortuneItemStyle(
                  borderWidth: 2,
                  borderColor: Colors.white,
                  color: (i % 2 == 0) ? segmentColors[0] : segmentColors[1],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: 30,
                      child: RotatedBox(
                        quarterTurns: 5,
                        child: Text(
                          discounts[i],
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        Center(
          child: Container(
            width: 45,
            height: 45,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Icon(
              LucideIcons.iceCreamCone300,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
