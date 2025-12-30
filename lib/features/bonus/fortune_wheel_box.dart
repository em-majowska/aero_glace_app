import 'dart:async';
import 'dart:math';

import 'package:aero_glace_app/features/bonus/fortune_wheel.dart';
import 'package:aero_glace_app/features/bonus/prize.dart';
import 'package:aero_glace_app/model/fortune_wheel_model.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FortuneWheelBox extends StatefulWidget {
  const FortuneWheelBox({super.key});

  @override
  State<FortuneWheelBox> createState() => _FortuneWheelBoxState();
}

class _FortuneWheelBoxState extends State<FortuneWheelBox> {
  final StreamController<int> controller = StreamController<int>();

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<FortuneWheelModel>(
          builder: (context, fortuneWheel, child) {
            final isActive = fortuneWheel.isWheelActive;
            final result = fortuneWheel.discounts[fortuneWheel.outcome];

            void spinTheWheel() {
              if (!isActive) return;
              final random = Random().nextInt(fortuneWheel.discounts.length);
              fortuneWheel.outcome = random;
              // _wheelController.add(_outcome);
              controller.add(fortuneWheel.outcome);
              fortuneWheel.updateState();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 24,
              children: [
                Center(
                  child: Text(
                    'Roue de la Fortune',
                    style:
                        Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 270,
                    height: 270,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.primaryFixedDim,
                      ),
                      shape: BoxShape.circle,
                    ),

                    // Fortune Wheel
                    child: FortuneWheelElement(
                      controller: controller,
                      onSpin: spinTheWheel,
                      result: result,
                    ),
                  ),
                ),
                if (!isActive)
                  Prize(
                    result: result,
                    isDiscount: fortuneWheel.isOutcomeDiscount,
                  ),
                Center(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: (isActive)
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                    ),
                    onPressed: (isActive) ? spinTheWheel : null,
                    child: () {
                      return (isActive)
                          ? Text(
                              'Tourner la roue !',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            )
                          : Text(
                              'Tentez votre chance demain !',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            );
                    }(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
