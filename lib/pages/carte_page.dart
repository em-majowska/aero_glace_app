import 'package:aero_glace_app/data/shop_locations.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:aero_glace_app/features/map/location_tile.dart';
import 'package:aero_glace_app/features/map/my_map.dart';
import 'package:flutter/material.dart';

final shops = shopLocations;

class CartePage extends StatefulWidget {
  const CartePage({super.key});

  @override
  State<CartePage> createState() => _CartePageState();
}

class _CartePageState extends State<CartePage> {
  final GlobalKey<MyMapState> myMapKey = GlobalKey<MyMapState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nos Glaciers'),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            const MyBackground(assetPath: 'background4.jpg'),
            Column(
              children: [
                Expanded(
                  child: MyMap(key: myMapKey, shops: shops),
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 24),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    itemCount: shops.length,
                    itemBuilder: (context, index) {
                      return LocationTile(
                        city: shops[index].city,
                        address: shops[index].address,
                        coordinates: shops[index].coordinates,
                        onPressed: myMapKey.currentState?.showLocation,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
