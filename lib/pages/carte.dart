import 'package:aero_glace_app/widgets/background.dart';
import 'package:aero_glace_app/features/map/location_tile.dart';
import 'package:aero_glace_app/features/map/my_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class ShopLocation {
  final String city;
  final String address;
  final LatLng coordinates;

  ShopLocation({
    required this.city,
    required this.address,
    required this.coordinates,
  });
}

class Carte extends StatefulWidget {
  const Carte({super.key});

  @override
  State<Carte> createState() => _CarteState();
}

class _CarteState extends State<Carte> {
  // All shops locations and coordinates
  final List<ShopLocation> shopLocations = [
    ShopLocation(
      city: 'Saint-Denis',
      address: '10 Pl. Sarda Garriga, Saint-Denis 97400',
      coordinates: const LatLng(-20.8734730, 55.4483322),
    ),
    ShopLocation(
      city: 'Saint-Paul',
      address: '14 Rue des Filaos, Saint-Paul 97460',
      coordinates: const LatLng(-21.0139205, 55.2611586),
    ),
    ShopLocation(
      city: 'Saint-Leu',
      address: '69 Rue du Lagon, Saint-Leu 97436',
      coordinates: const LatLng(-21.1759453, 55.2873976),
    ),
    ShopLocation(
      city: 'Saint-Pierre',
      address: '9 Rue Suffren, Saint-Pierre 97410',
      coordinates: const LatLng(-21.3412572, 55.4713007),
    ),
  ];

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
                  child: MyMap(shopLocations: shopLocations),
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 24),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    itemCount: shopLocations.length,
                    itemBuilder: (context, index) {
                      return LocationTile(
                        city: shopLocations[index].city,
                        address: shopLocations[index].address,
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
