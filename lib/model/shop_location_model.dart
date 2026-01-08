import 'package:latlong2/latlong.dart';

/// Widget représentant une boutique avec son emplacement géographique.
///
/// Utilisées pour l'affichage sur une carte et pour calculer un itinéraire
/// depuis la position de l’utilisateur.
///
/// Arguments :
/// - [city] : nom de la ville où se situe la boutique.
/// - [address] : adresse complète de la boutique.
/// - [coordinates] : coordonnées géographique de la boutique.
class ShopLocation {
  /// Nom de la ville où se situe la boutique.
  final String city;

  /// Adresse complète de la boutique.
  final String address;

  /// Coordonnées géographique de la boutique.
  ///
  /// Utilisées pour l'affichage sur une carte et pour calculer un itinéraire
  /// depuis la position de l’utilisateur.
  final LatLng coordinates;

  /// Crée un objet [ShopLocation] avec la ville, l’adresse et
  /// les coordonnées.
  ShopLocation({
    required this.city,
    required this.address,
    required this.coordinates,
  });
}
