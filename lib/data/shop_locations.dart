import 'package:aero_glace_app/model/shop_location_model.dart';
import 'package:latlong2/latlong.dart';

/// Liste des boutiques avec leurs coordonnées géographiques.
///
/// Contient :
/// - [city] : nom de la ville.
/// - [address] : adresse complète de la boutique.
/// - [coordinates] : latitude et longitude de la boutique ([LatLng])
/// Utilisées pour l’affichage sur la carte.
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
