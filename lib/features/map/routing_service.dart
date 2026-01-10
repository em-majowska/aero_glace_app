import 'dart:convert';

import 'package:aero_glace_app/features/map/decode_polyline.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

/// Récupère l’itinéraire entre [_currentLocation] et [_destination] via l’OSRM API.
class RouteService {
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

    return decodedRoute(geometry);
  }
}
