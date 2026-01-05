import 'package:aero_glace_app/data/default_flavors.dart';
import 'package:aero_glace_app/features/flavors/flavor_tile.dart';
import 'package:aero_glace_app/model/cart_model.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:aero_glace_app/model/snack_bar.dart';
import 'package:aero_glace_app/util/language_menu_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

// show message

void _showMessage(BuildContext context, Flavor flavor) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    MySnackBar(
      context: context,
      icon: Icon(
        LucideIcons.circleCheck300,
        color: Theme.of(context).colorScheme.tertiary,
      ),
      message: context.tr(
        'added_to_cart',
        namedArgs: {
          'flavorTitle': flavor.title,
        },
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
    final flavors = getDefaultFlavors(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('nos_parfums')),
        actions: [const LanguageMenuButton()],
      ),
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
