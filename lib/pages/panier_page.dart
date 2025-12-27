import 'package:aero_glace_app/features/panier/cart_provider.dart';
import 'package:aero_glace_app/model/flavor_model.dart';
import 'package:aero_glace_app/features/panier/cart_item_tile.dart';
import 'package:aero_glace_app/features/panier/empty_cart_tile.dart';
import 'package:aero_glace_app/features/panier/total_tile.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PanierPage extends StatefulWidget {
  const PanierPage({super.key});

  @override
  State<PanierPage> createState() => _PanierPageState();
}

class _PanierPageState extends State<PanierPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => Scaffold(
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
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                value.getUserCart().isEmpty
                    ? const EmptyCartTile()
                    : GlossyBox(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 12),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemCount: value.getUserCart().length,
                          itemBuilder: (context, index) {
                            Flavor item = value.getUserCart()[index];

                            return CartItemTile(flavor: item);
                          },
                        ),
                      ),
                const SizedBox(height: 24),
                if (value.getUserCart().isNotEmpty) const TotalTile(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
