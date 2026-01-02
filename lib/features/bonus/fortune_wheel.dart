import 'dart:async';
import 'package:aero_glace_app/model/cart_model.dart';
import 'package:aero_glace_app/model/fortune_wheel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class FortuneWheelElement extends StatelessWidget {
  final StreamController<int> controller;
  final VoidCallback onSpin;

  const FortuneWheelElement({
    super.key,
    required this.controller,
    required this.onSpin,
  });

  static final segmentColors = [
    Colors.blue.shade100,
    Colors.red.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: Consumer<FortuneWheelModel>(
            builder: (context, fortuneWheel, child) {
              return FortuneWheel(
                physics: CircularPanPhysics(
                  duration: const Duration(seconds: 1),
                  curve: Curves.decelerate,
                ),
                hapticImpact: HapticImpact.light,
                selected: controller.stream,
                onFling: onSpin,
                onAnimationEnd: () {
                  if (!fortuneWheel.isWheelActive) return;

                  final cart = Provider.of<Cart>(context, listen: false);
                  final now = DateTime.now();

                  fortuneWheel.disableWheel(now);
                  if (fortuneWheel.outcome.type == 'discount') {
                    cart.setDiscount(fortuneWheel.outcome.value, now);
                  } else {
                    cart.setDiscount(0, now);
                    fortuneWheel.addPoints(fortuneWheel.outcome.value);
                  }
                },
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

                // items
                items: List.generate(fortuneWheel.fortuneItems.length, (i) {
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
                          // position the outcome on the wheel
                          right: 20,
                          child: RotatedBox(
                            quarterTurns: 5,
                            child: Text(
                              fortuneWheel.displayValue(
                                fortuneWheel.fortuneItems[i],
                              ),
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              );
            },
          ),
        ),
        Center(
          child: Container(
            width: 45,
            height: 45,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
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
