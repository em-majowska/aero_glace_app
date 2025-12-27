// import 'package:aero_glace_app/util/background.dart';
import 'package:aero_glace_app/data/default_flavors.dart';
import 'package:aero_glace_app/features/flavors/flavor_tile.dart';
import 'package:aero_glace_app/features/panier/cart_provider.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

// import 'package:lucide_icons_flutter/lucide_icons.dart';

final flavorsList = defaultFlavors;

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
  // add to cart
  void addFlavorToCart(Flavor flavor) {
    Provider.of<CartProvider>(context, listen: false).addItemToCart(flavor);
    _showMessage(context, flavor);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => Scaffold(
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
            return FlavorTile(
              flavor: flavor,
              onPressed: () => addFlavorToCart(flavor),
            );
          },
        ),
      ),
    );
  }
}
