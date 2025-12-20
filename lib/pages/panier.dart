import 'package:aero_glace_app/util/background.dart';
import 'package:aero_glace_app/util/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Panier extends StatefulWidget {
  const Panier({super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Votre Commande'),
      ),
      body: Stack(
        children: [
          const MyBackground(assetPath: 'background.jpg'),
          Positioned(
            bottom: -200,
            right: -80,
            child: Image.asset(
              'assets/images/hovering-elements.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: GlossyBox(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(LucideIcons.handbag200, size: 85),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Text(
                        'Votre panier est vide',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
