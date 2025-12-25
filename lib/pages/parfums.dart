// import 'package:aero_glace_app/util/background.dart';
import 'package:aero_glace_app/data/default_flavors.dart';
import 'package:aero_glace_app/features/flavors/flavor_tile.dart';
import 'package:flutter/material.dart';

// import 'package:lucide_icons_flutter/lucide_icons.dart';

final flavorsList = defaultFlavors;

class Parfums extends StatelessWidget {
  const Parfums({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nos Parfums')),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: flavorsList.length,
        itemBuilder: (context, index) {
          final flavor = flavorsList[index];
          return FlavorTile(flavor: flavor);
        },
      ),
    );
  }
}
