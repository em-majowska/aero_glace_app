import 'package:aero_glace_app/data/default_flavors.dart';
import 'package:aero_glace_app/features/flavors/flavor_tile.dart';
import 'package:aero_glace_app/features/panier/cart_model.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

final flavors = defaultFlavors;

// show message

void _showMessage(BuildContext context, Flavor flavor) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.all(12),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      content: Row(
        spacing: 8,
        children: [
          Icon(
            LucideIcons.circleCheck300,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          Text(
            '${flavor.title} ajouté au panier',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    ),
  );
}

class ParfumsPage extends StatefulWidget {
  const ParfumsPage({super.key});

  @override
  State<ParfumsPage> createState() => _ParfumsPageState();
}

class _ParfumsPageState extends State<ParfumsPage> {
  // add flavor to cart via cart provider function
  void addFlavorToCart(Flavor flavor) {
    Provider.of<Cart>(context, listen: false).addItem(flavor);
    _showMessage(context, flavor);
  }

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
        itemCount: flavors.length,
        itemBuilder: (context, index) {
          final flavor = flavors[index];
          return FlavorTile(
            flavor: flavor,
            onPressed: () => addFlavorToCart(flavor),
          );
        },
      ),
    );
  }
}
