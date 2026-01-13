import 'package:aero_glace_app/models/shop_location_model.dart';
import 'package:aero_glace_app/utils/context_extensions.dart';
import 'package:aero_glace_app/widgets/glossy_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

/// Couche de tuiles pour afficher la carte OpenStreetMap.
///
/// Cette couche utilise les tuiles d'OpenStreetMap pour afficher la carte de base.
/// Le `userAgentPackageName` est requis pour identifier l'application auprès du serveur de tuiles.
Widget mapView() {
  return TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'com.aero_glace_app/1.0.0',
  );
}

/// Couche pour afficher un itinéraire sur la carte sous forme de polyligne.
///
/// Cette couche prend une liste de points `LatLng` représentant l'itinéraire
/// et les affiche comme une ligne bleue sur la carte.
///
/// Paramètres :
/// - [route] : Liste de coordonnées `LatLng` définissant l'itinéraire.
Widget polylines(List<LatLng> route) {
  return PolylineLayer(
    polylines: [
      Polyline(
        points: route,
        strokeWidth: 5,
        color: Colors.blue,
      ),
    ],
  );
}

/// Couche pour afficher des marqueurs avec des fenêtres popups sur la carte.
///
/// Cette couche gère l'affichage des marqueurs pour chaque boutique et permet
/// d'afficher une fenêtre popup lorsque l'utilisateur clique sur un marqueur.
/// La popup contient l'adresse de la boutique et un bouton pour calculer l'itinéraire.
///
/// Paramètres :
/// - [markers] : Liste des marqueurs à afficher sur la carte.
/// - [shops] : Liste des boutiques associées aux marqueurs.
/// - [controller] : Contrôleur pour gérer l'affichage des popups.
/// - [showRoute] : Fonction appelée pour afficher l'itinéraire vers la boutique sélectionnée.
Widget popupWindow(
  List<Marker> markers,
  List<ShopLocation> shops,
  PopupController controller,
  void Function(LatLng) showRoute,
) {
  return PopupMarkerLayer(
    options: PopupMarkerLayerOptions(
      markers: markers,
      popupController: controller,
      markerCenterAnimation: const MarkerCenterAnimation(),
      popupDisplayOptions: PopupDisplayOptions(
        builder: (BuildContext context, Marker marker) {
          // Trouve la boutique associée au marqueur cliqué
          final shop = shops.firstWhere(
            (shop) => shop.coordinates == marker.point,
          );
          return popupWindowChild(
            context,
            shop,
            () {
              showRoute(
                shop.coordinates,
              ); // Affiche l'itinéraire vers la boutique
              controller.hideAllPopups(); // Ferme la popup après le clic
            },
          );
        },
      ),
    ),
  );
}

/// Contenu de la fenêtre popup affichée lors du clic sur un marqueur.
Widget popupWindowChild(
  BuildContext context,
  ShopLocation shop,
  VoidCallback onPressed,
) {
  return Container(
    decoration: BoxDecoration(
      color: context.colorSchema.surface,
      borderRadius: BorderRadius.circular(12),
    ),
    constraints: const BoxConstraints(
      maxWidth: 200,
      maxHeight: 70,
    ),
    child: Row(
      children: [
        // Adresse de la boutique
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              shop.address,
              style: context.textTheme.labelSmall,
            ),
          ),
        ),

        // Bouton
        SizedBox(
          height: double.infinity,
          child: IconButton(
            onPressed: onPressed,
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(12),
              backgroundColor: context.colorSchema.tertiaryContainer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
            icon: Icon(
              LucideIcons.navigation,
              color: context.colorSchema.onTertiaryContainer,
            ),
          ),
        ),
      ],
    ),
  ).animate().fadeIn();
}

/// Fenêtre d'aperçu affichant la distance entre l'utilisateur et
/// la destination.
///
/// Paramètres :
/// - [context] : Contexte Flutter pour accéder au thème et aux ressources.
/// - [title] : Titre de la destination (ex: nom de la ville).
/// - [distance] : Distance en kilomètres entre l'utilisateur et la destination.
Widget distancePreview(
  BuildContext context,
  title,
  double? distance,
  double? duration,
) {
  return Positioned(
    bottom: 5,
    left: 5,
    child: GlossyBox(
      width: 260,
      height: 75,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Animate(key: ValueKey<dynamic>(title))
                .toggle(
                  builder: (context, value, child) => AnimatedContainer(
                    duration: 200.ms,
                    child: Text(
                      '${context.tr('aero_glace')} - $title',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                )
                .fadeIn(),

            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Animate(key: ValueKey<double?>(distance))
                    .toggle(
                      builder: (_, value, _) => AnimatedContainer(
                        duration: 200.ms,
                        child: Text(
                          distance != null
                              ? '${distance.toStringAsFixed(2)} ${context.tr('km')}'
                              : context.tr('distance_loading'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    )
                    .fadeIn(),
                Animate(key: ValueKey<double?>(duration))
                    .toggle(
                      builder: (_, value, _) => AnimatedContainer(
                        duration: 200.ms,
                        child: Text(
                          duration != null
                              ? '${duration.toStringAsFixed(0)} ${context.tr('mins')}'
                              : '',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    )
                    .fadeIn(),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(),
  );
}

/// Filigrane pour attribuer les contributeurs d'OpenStreetMap.
Widget watermark() {
  return RichAttributionWidget(
    attributions: [
      TextSourceAttribution(
        '© OpenStreetMap contributors',
        onTap: () => launchUrl(
          Uri.parse('https://www.openstreetmap.org/copyright'),
        ),
      ),
    ],
  );
}

/// Bouton flottant pour centrer la carte sur la position actuelle
/// de l'utilisateur.
///
/// Déclenche la fonction `_userCurrentLocation`
/// pour recentrer la carte sur la position GPS de l'utilisateur.
Widget floatingBtn(BuildContext context, curLocation) {
  return FloatingActionButton(
    onPressed: curLocation,
    backgroundColor: context.colorSchema.tertiaryContainer,
    child: Icon(
      LucideIcons.locateFixed300,
      color: context.colorSchema.onTertiaryContainer,
      size: 30,
    ),
  );
}
