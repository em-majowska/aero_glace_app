import 'dart:async';
import 'package:aero_glace_app/features/bonus/fortune_wheel.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';

StreamController<int> controller = StreamController<int>();

class FortuneWheelBox extends StatelessWidget {
  const FortuneWheelBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GlossyBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 24,
          children: [
            Center(
              child: Text(
                'Roue de la Fortune',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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
                  borderRadius: BorderRadius.circular(150),
                ),
                child: const FortuneWheelElement(),
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.deepPurpleAccent.shade400,
                  backgroundColor: Colors.deepPurple.shade400,
                ),
                onPressed: () {},
                child: Text(
                  'Tourner la roue !',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
