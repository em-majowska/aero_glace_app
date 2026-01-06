import 'package:aero_glace_app/util/language_menu_btn.dart';
import 'package:easy_localization/easy_localization.dart';
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

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('aero_glace')),
        actions: [const LanguageMenuButton()],
      ),
      body: Stack(
        children: [
          const MyBackground(assetPath: 'background.jpg'),

          // Blob top left
          Positioned(
            top: mediaHeight * -0.13,
            right: mediaWidth * -0.2,
            child: Blob.random(
              // size: 400,
              size: mediaWidth * 0.8,
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
            top: mediaHeight * 0.05,
            left: 0,
            child: Blur(
              blur: 2,
              child: RotatedBox(
                quarterTurns: -1,
                child: Image.asset(
                  'assets/images/star.png',
                  width: mediaWidth * 0.4,
                ),
              ),
            ),
          ),

          // Blob top left
          Positioned(
            top: mediaHeight * -0.2,
            left: mediaWidth * -0.4,
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
            bottom: mediaHeight * -0.15,
            right: mediaWidth * -0.4,
            child: Blob.random(
              size: mediaHeight * 0.45,
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
            bottom: mediaHeight * -0.17,
            left: mediaWidth * -0.45,
            child: Blob.random(
              size: mediaHeight * 0.45,
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
          //Outlined sparkle bottom left
          Positioned(
            left: mediaWidth * 0.1,
            bottom: mediaHeight * 0.07,
            child: Icon(LucideIcons.sparkles100, size: mediaWidth * 0.2),
          ),
          // Outlined sparkle top right
          Positioned(
            right: mediaWidth * 0.1,
            top: mediaHeight * 0.17,
            child: Icon(LucideIcons.sparkle100, size: mediaWidth * 0.12),
          ),
          // Star image bottom right
          Positioned(
            bottom: mediaHeight * 0.1,
            right: mediaWidth * 0.2,
            child: Image.asset(
              'assets/images/star.png',
              width: mediaWidth * 0.15,
            ),
          ),

          // Center elements
          Center(
            child: Container(
              width: mediaWidth * 0.6,
              height: mediaWidth * 0.6,
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
              width: mediaWidth * 0.5,
              height: mediaWidth * 0.5,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/ice-cream.png',
              width: mediaWidth * 0.35,
            ),
          ),
        ],
      ),
    );
  }
}
