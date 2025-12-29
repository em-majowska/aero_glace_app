import 'package:flutter/material.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:blobs/blobs.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  // language selection menu
  void openLanguageMenu() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Langue'),
          titleTextStyle: Theme.of(context).textTheme.titleLarge,
          alignment: Alignment.topRight,
          constraints: const BoxConstraints(maxWidth: 180),
          contentPadding: const EdgeInsetsGeometry.all(16),
          children: [
            SimpleDialogOption(
              onPressed: () {},
              child: const Row(
                children: [
                  Text('FR'),
                  SizedBox(width: 16),
                  Text('Français'),
                ],
              ),
            ),
            const Divider(),
            SimpleDialogOption(
              onPressed: () {},
              child: const Row(
                children: [
                  Text('JP'),
                  SizedBox(width: 16),
                  Text('Japonais'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aero Glace'),
        actions: [
          IconButton(
            onPressed: openLanguageMenu,
            icon: const Icon(LucideIcons.settings200, size: 35),
          ),
        ],
      ),
      body: Stack(
        children: [
          const MyBackground(assetPath: 'background2.jpg'),

          // Blob top left
          Positioned(
            top: -100,
            right: -150,
            child: Blob.random(
              size: 400,
              edgesCount: 15,
              styles: BlobStyles(
                fillType: BlobFillType.stroke,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFffffff).withValues(alpha: 0.95),
                    const Color(0xFFFFFFFF).withValues(alpha: 0.70),
                  ],
                ).createShader(const Rect.fromLTRB(0, 0, 100, 100)),
                strokeWidth: 2,
              ),
            ),
          ),

          Positioned(
            top: 50,
            left: 0,
            child: Blur(
              blur: 2,
              child: RotatedBox(
                quarterTurns: -1,
                child: Image.asset(
                  'assets/images/star.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          ),

          // Blob top left
          Positioned(
            top: -200,
            left: -150,
            child: Blob.random(
              size: 500,
              edgesCount: 10,
              styles: BlobStyles(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFffffff).withValues(alpha: 0.35),
                    const Color(0xFFFFFFFF).withValues(alpha: 0.50),
                  ],
                ).createShader(const Rect.fromLTRB(0, 0, 100, 100)),
              ),
            ),
          ),

          // Blob bottom right
          Positioned(
            bottom: -150,
            right: -150,
            child: Blob.random(
              size: 400,
              edgesCount: 20,
              // minGrowth: 8,
              // duration: Duration(milliseconds: 2000),
              // loop: true,
              styles: BlobStyles(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFffffff).withValues(alpha: 0.35),
                    const Color(0xFFFFFFFF).withValues(alpha: 0.50),
                  ],
                ).createShader(const Rect.fromLTRB(0, 0, 100, 100)),
              ),
            ),
          ),

          // Blob bottom-left
          Positioned(
            bottom: -150,
            left: -200,
            child: Blob.random(
              size: 400,
              edgesCount: 15,
              styles: BlobStyles(
                fillType: BlobFillType.stroke,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFffffff).withValues(alpha: 0.95),
                    const Color(0xFFFFFFFF).withValues(alpha: 0.70),
                  ],
                ).createShader(const Rect.fromLTRB(0, 0, 100, 100)),
                strokeWidth: 2,
              ),
            ),
          ),
          const Positioned(
            left: 50,
            bottom: 120,
            child: Icon(
              LucideIcons.sparkles100,
              size: 80,
            ),
          ),
          const Positioned(
            right: 50,
            top: 150,
            child: Icon(
              LucideIcons.sparkle100,
              size: 70,
            ),
          ),
          Positioned(
            bottom: 120,
            right: 80,
            child: Image.asset(
              'assets/images/star.png',
              width: 60,
              height: 60,
            ),
          ),

          // Center elements
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0x00000000).withValues(alpha: 0.10),
                border: Border.all(
                  color: const Color(0x00000000).withValues(alpha: 0.70),
                ),
                borderRadius: BorderRadius.circular(250),
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.40),
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(250),
              ),
              width: 200,
              height: 200,
            ),
          ),
          Center(
            child: Image.asset('assets/images/ice-cream2.png', width: 150),
          ),
        ],
      ),
    );
  }
}
