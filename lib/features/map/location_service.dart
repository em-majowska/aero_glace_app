import 'dart:async';

import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationService {
  /// Service de localisation de l'utilisateur.
  final Location _location = Location();

  /// Abonnement à la mise à jour de la localisation de l’utilisateur.
  StreamSubscription<LocationData>? _locationSubscription;

  Future<bool> isServiceEnabled() async {
    return await _location.serviceEnabled();
  }

  Future<bool> requestService() async {
    return await _location.requestService();
  }

  Stream<LatLng> get onLocationChanged {
    return _location.onLocationChanged.map(
      (data) => LatLng(data.latitude!, data.longitude!),
    );
  }

  void dispose() {
    _locationSubscription?.cancel();
  }
}
