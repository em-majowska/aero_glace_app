import 'dart:async';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

/// Service pour gérer la localisation de l'utilisateur.
class LocationService {
  // Service de localisation de l'utilisateur.
  final Location _location = Location();

  /// Abonnement au flux de données de localisation.
  ///
  /// Ce [StreamSubscription] est utilisé pour écouter les mises à jour de la position
  /// de l'utilisateur. Il doit être annulé dans [dispose] pour éviter les fuites de mémoire.
  StreamSubscription<LocationData>? _locationSubscription;

  /// Vérifie si le service de localisation est activé sur l'appareil.
  Future<bool> isServiceEnabled() async {
    return await _location.serviceEnabled();
  }

  /// Demande à l'utilisateur d'activer le service de localisation.
  ///
  /// Cette méthode affiche une boîte de dialogue système demandant à l'utilisateur
  /// d'activer le service de localisation de l'appareil.
  Future<bool> requestService() async {
    return await _location.requestService();
  }

  /// Flux de données représentant les changements de localisation de l'utilisateur.
  ///
  /// Ce getter retourne un [Stream] de [LatLng] qui émet une nouvelle position
  /// chaque fois que la localisation de l'utilisateur change.
  Stream<LatLng> get onLocationChanged {
    return _location.onLocationChanged.map(
      (data) => LatLng(data.latitude!, data.longitude!),
    );
  }

  /// Libère les ressources utilisées par le service de localisation.
  ///
  /// Cette méthode annule l'abonnement au flux de localisation ([_locationSubscription])
  /// pour éviter les fuites de mémoire.
  void dispose() {
    _locationSubscription?.cancel();
  }
}
