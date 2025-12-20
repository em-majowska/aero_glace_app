// import 'package:aero_glace_app/util/background.dart';
import 'package:aero_glace_app/util/flavor_tile.dart';
import 'package:flutter/material.dart';
// import 'package:lucide_icons_flutter/lucide_icons.dart';

final List flavorsList = ['chocolate', 'strawberry'];

class Parfums extends StatefulWidget {
  const Parfums({super.key});

  @override
  State<Parfums> createState() => _ParfumsState();
}

class _ParfumsState extends State<Parfums> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nos Parfums')),
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: flavorsList.length,
          itemBuilder: (context, index) =>
              FlavorTile(flavor: flavorsList[index]),
        ),
      ),
    );
  }
}
