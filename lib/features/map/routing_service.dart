import 'dart:convert';
import 'package:aero_glace_app/features/map/decode_polyline.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

/// Service pour récupérer les itinéraires entre deux points géographiques via l’OSRM API.
class RouteService {
  double? duration;

  /// Récupère l’itinéraire entre [_currentLocation] et [_destination] via l’OSRM API.
  ///
  /// Arguments :
  /// - [start] : Point de départ de l'itinéraire (coordonnées géographiques).
  /// - [end] : Destination de l'itinéraire (coordonnées géographiques).
  ///
  /// Retourne :
  /// - Une [List] de [LatLng] représentant les points de l'itinéraire.
  /// - Une [Exception] si la requête échoue (par exemple, en cas d'erreur réseau
  ///   ou de réponse invalide de l'API)
  Future<List<LatLng>> fetchRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    final url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/'
      '${start.longitude},${start.latitude};'
      '${end.longitude},${end.latitude}?overview=full&geometries=polyline',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch route: ${response.statusCode}');
    }

    final data = json.decode(response.body);
    final geometry = data['routes'][0]['geometry'];
    duration = (data['routes'][0]['duration'] / 60);

    return decodedRoute(geometry);
  }

  double get getDuration => duration!;
}
