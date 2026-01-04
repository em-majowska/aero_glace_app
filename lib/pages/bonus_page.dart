import 'package:aero_glace_app/features/bonus/collected_points_box.dart';
import 'package:aero_glace_app/features/bonus/fortune_wheel_box.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BonusPage extends StatelessWidget {
  const BonusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "bonus")),
      ),
      body: Stack(
        children: [
          const MyBackground(assetPath: 'background4.jpg'),
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const CollectedPointsBox(),
              const SizedBox(height: 32),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 24,
                children: [
                  Icon(
                    LucideIcons.sparkles200,
                    size: 24,
                  ),
                  Icon(
                    LucideIcons.sparkles200,
                    size: 24,
                  ),
                  Icon(
                    LucideIcons.sparkles200,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const FortuneWheelBox(),
            ],
          ),
        ],
      ),
    );
  }
}
