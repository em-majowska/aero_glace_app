import 'package:aero_glace_app/features/bonus/collected_points_tile.dart';
import 'package:aero_glace_app/features/bonus/fortune_wheel_tile.dart';
import 'package:aero_glace_app/widgets/language_menu_btn.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class BonusPage extends StatelessWidget {
  const BonusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('bonus')),
        actions: [const LanguageMenuButton()],
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0.0,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const MyBackground(assetPath: 'background3.jpg'),
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const CollectedPoints(),
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
