import 'package:latlong2/latlong.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart'
    show decodePolyline;
export 'package:google_polyline_algorithm/google_polyline_algorithm.dart'
    show decodePolyline;

extension PolylineExt on List<List<num>> {
  List<LatLng> unpackPolyline() =>
      map((p) => LatLng(p[0].toDouble(), p[1].toDouble())).toList();
}

/// Décode le polyline obtenu depuis l’API en liste de points pour affichage.
List<LatLng> decodedRoute(String encodedPolyline) {
  return decodePolyline(encodedPolyline).unpackPolyline();
}
