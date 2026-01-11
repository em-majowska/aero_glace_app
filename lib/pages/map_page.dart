import 'package:aero_glace_app/data/shop_locations.dart';
import 'package:aero_glace_app/utils/animations.dart';
import 'package:aero_glace_app/utils/theme.dart';
import 'package:aero_glace_app/widgets/language_menu_btn.dart';
import 'package:aero_glace_app/widgets/background.dart';
import 'package:aero_glace_app/features/cart/location_tile.dart';
import 'package:aero_glace_app/features/cart/my_map.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Page affichant la carte des boutiques et la liste des emplacements.
///
/// Retourne un [Scaffold] contenant une [AppBar] incluant un sélecteur
/// de langue et :
/// - La carte ([MyMap]) affiche les emplacements des boutiques
/// avec des marqueurs.
/// - La liste ([LocationTile]) permet de sélectionner
/// un emplacement et d’interagir avec la carte pour centrer sur celui-ci.
/// - Utilise un [GlobalKey] pour accéder aux méthodes de [MyMap]
/// depuis la liste.
class MapPage extends StatefulWidget {
  /// Crée la page de carte des boutiques.
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  /// Clé globale pour accéder aux méthodes et à l'état de [MyMap].
  final GlobalKey<MyMapState> myMapKey = GlobalKey<MyMapState>();
  final shops = shopLocations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('nos_glaciers')),
        actions: [const LanguageMenuButton()],
        backgroundColor: context.colorSchema.surface,
        scrolledUnderElevation: 0.0,
        shadowColor: Colors.transparent,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            const MyBackground(assetPath: 'background3.jpg'),
            Column(
              children: [
                /// Carte affichant les marqueurs des boutiques.
                Expanded(
                  child: MyMap(
                    key: myMapKey,
                    shops: shops,
                  ),
                ).animate(delay: 200.ms).fadeIn(),

                /// Liste des boutiques avec possibilité de centrer la carte sur un emplacement.
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
                            onPressed: myMapKey.currentState?.showRoute,
                          )
                          .animate(delay: 400.ms)
                          .fadeOut(begin: 0)
                          .swap(
                            builder: (context, child) => child!.animate(
                              delay: Duration(milliseconds: index * 300),
                              effects: slideIn,
                            ),
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
